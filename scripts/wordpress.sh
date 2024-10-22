#!/bin/bash

# Update package information and repositories
dnf -y update

# Upgrade installed packages to the latest versions
dnf -y upgrade

# Install Apache web server (httpd)
dnf -y install httpd

# (Optional) If using Red Hat, enable the CodeReady Builder repositories:
# subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms

# Install EPEL (Extra Packages for Enterprise Linux) repository
dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

# Install the Remi repository for PHP 8.3 version
dnf -y install https://rpms.remirepo.net/enterprise/remi-release-9.rpm

# Enable the Remi module for PHP 8.3
dnf -y module enable php:remi-8.3

# Install PHP and necessary extensions for WordPress (MySQL, GD, XML, Mbstring, Redis...)
dnf -y install php php-mysqlnd php-gd php-xml php-mbstring php-redis php-pecl-imagick php-pecl-zip php-intl

# Download the latest WordPress release
curl -O https://wordpress.org/latest.tar.gz

rm -rf /var/www/html/*

# Extract the WordPress files and move them to the /var/www/html/ directory
tar -xf latest.tar.gz --strip-components=1 -C /var/www/html/

# Remove the downloaded WordPress archive file
rm -rf latest.tar.gz

# Download WP-CLI (WordPress Command Line Interface)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Make WP-CLI executable
chmod +x wp-cli.phar

# Move WP-CLI to the /usr/bin directory for easier access
mv wp-cli.phar /usr/bin/wp

# Create the WordPress configuration file (wp-config.php) with specific content
cat <<EOF > /var/www/html/wp-config.php
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '${WP_DB_NAME}' );

/** Database username */
define( 'DB_USER', '${WP_DB_USERNAME}' );

/** Database password */
define( 'DB_PASSWORD', '${WP_DB_PASSWORD}' );

/** Database hostname */
define( 'DB_HOST', '${WP_DB_ENDPOINT}' );

/** Database charset to use in creating database tables.  */
define( 'DB_CHARSET', '${WP_DB_CHARSET}' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */

$(curl https://api.wordpress.org/secret-key/1.1/salt/)

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
\$table_prefix = '${WP_DB_TABLE_PREFIX}';

// adjust Redis host and port if necessary 
define( 'WP_REDIS_HOST', '${WP_REDIS_ENDPOINT}' );
define( 'WP_REDIS_PORT', ${WP_REDIS_PORT} );

// change the prefix and database for each site to avoid cache data collisions
define( 'WP_REDIS_PREFIX', '${WP_REDIS_PREFIX}' );
define( 'WP_REDIS_DATABASE', ${WP_REDIS_DATABASE} ); // 0-15

// reasonable connection and read+write timeouts
define( 'WP_REDIS_TIMEOUT', ${WP_REDIS_TIMEOUT} );
define( 'WP_REDIS_READ_TIMEOUT', ${WP_REDIS_READ_TIMEOUT} );

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', ${WP_DEBUG} );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
EOF

cat <<EOF > /etc/httpd/conf.d/wordpress.conf
<VirtualHost *:80>
    ServerAdmin ${SERVER_ADMIN_EMAIL}
    DocumentRoot /var/www/html

    ServerName ${ALB_DNS_NAME}
    
    <IfModule mod_headers.c>
        Header set Cache-Control "public, max-age=31536000"
    </IfModule>

    <IfModule mod_expires.c>
        ExpiresActive On
        ExpiresByType text/html "access plus 1 day"
        ExpiresByType text/css "access plus 1 month"
        ExpiresByType application/javascript "access plus 1 month"
        ExpiresByType image/jpeg "access plus 1 year"
        ExpiresByType image/png "access plus 1 year"
        ExpiresByType image/gif "access plus 1 year"
    </IfModule>

    # Log Settings
    ErrorLog /var/log/httpd/error.log
    CustomLog /var/log/httpd/access.log combined
</VirtualHost>
EOF

cd /var/www/html/

# Install WordPress core with provided URL, title, admin user, password, and email
wp core install --url=${ALB_DNS_NAME} \
 --title="${WP_TITLE}" \
 --admin_user="${WP_ADMIN_USER}" \
 --admin_password="${WP_ADMIN_PASSWORD}" \
 --admin_email="${WP_ADMIN_EMAIL}" \
 --path=/var/www/html

# Install Redis cache plugin for WordPress
wp plugin install redis-cache

# Change ownership of the WordPress directory to Apache user and group
chown -R apache:apache /var/www/html/

# Set directory and files permissions for WordPress
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;
chmod 640 /var/www/html/wp-config.php

# Activate the Redis cache plugin
wp plugin activate redis-cache

# Enable Redis object caching in WordPress
wp redis enable

# Set the WordPress filesystem method to 'direct' to allow updates without FTP credentials
wp config set FS_METHOD 'direct'

# Set the WordPress memory limit to 256 MB
wp config set WP_MEMORY_LIMIT '256'

# Delete the 'Akismet' plugin
wp plugin delete akismet

# Delete the 'Hello Dolly' plugin
wp plugin delete hello

# Delete the 'Twenty Twenty-Three' theme
wp theme delete twentytwentythree

# Delete the 'Twenty Twenty-Two' theme
wp theme delete twentytwentytwo

# Enable SELinux rule to allow Apache (httpd) to connect to the network
setsebool -P httpd_can_network_connect 1

# This command enables the SELinux boolean `httpd_unified`, allowing Apache (httpd) to read/write files, execute scripts, and connect to the network with a unified SELinux context.
# It is useful when multiple permissions are required by the web server.
setsebool -P httpd_unified 1

# Enable Apache HTTP server to start on boot
systemctl enable httpd

# Reboot the system to apply changes
systemctl reboot
