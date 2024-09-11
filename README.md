Description:

This script set is used to manage OpenLiteSpeed server and MySQL services on AaPanel:

OpenLiteSpeed Restart: Monitors changes in .htaccess files in the website directory. It records the modification dates and directories of these .htaccess files. When a change is detected, it restarts the OpenLiteSpeed (OLS) service to ensure that the updated .htaccess file is applied. This helps avoid system load.

MySQL Service Check: Monitors the status of the MySQL service. If the service is found to be stopped, it will automatically restart it.

Cache Management: To prevent storage bloat from cache files saved by the OLSCache plugin on WordPress sites running on the OLS server, it checks the cached files every hour and deletes those older than 2 days.

Setup Instructions:

Create a directory named /www/foxdimShells/ and place the required script files into this directory.
Set the directory and file permissions to 755.
To run the scripts, schedule /www/FoxdimShell/index.sh to be called by cron at regular intervals. For example, every 1-2 minutes should be sufficient.


-----------------------------------------------------------------------------------------------------------

Açıklama:

Bu script seti, AaPanel üzerinde OpenLiteSpeed sunucusunu ve MySQL servislerini yönetmek için kullanılır:

OpenLiteSpeed Yeniden Başlatma: Websitesi dizinindeki .htaccess dosyalarında görülen değişiklikleri izler. .htaccess dosyalarının değişiklik tarihlerini ve dizinlerini kaydeder. Bir değişiklik algılandığında, OpenLiteSpeed (OLS) servisini yeniden başlatarak güncel .htaccess dosyasının geçerli olmasını sağlar. Bu, sistem üzerinde yük bindirmemek için yapılır.

MySQL Servisi Kontrolü: MySQL servisinin kapanmasını kontrol eder. Eğer servis kapalıysa, otomatik olarak yeniden başlatır.

Cache Yönetimi: OLS sunucusunda çalışan WordPress sitelerinin OLSCache eklentisi tarafından kaydedilen dosyaların depolama alanında şişkinlik yapmasını engellemek için, cache dosyalarını saatte bir kontrol eder ve 2 günden eski olanları siler.

Kurulum Talimatları:

/www/foxdimShells/ dizinini oluşturun ve gerekli script dosyalarını bu dizine yerleştirin.
Dizin ve dosyaların izinlerini 755 olarak ayarlayın.
Script dosyalarını çalıştırmak için /www/FoxdimShell/index.sh dosyasını cron ile belirli aralıklarla çalışacak şekilde ayarlayın. Örneğin, her 1-2 dakikada bir çalışacak şekilde yapılandırabilirsiniz.
