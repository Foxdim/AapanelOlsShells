#!/bin/bash
script_dir="$(dirname "$(realpath "$0")")"

# LightSpeed Web Server'ın kontrol komutu
lsws_restart_cmd="/usr/local/lsws/bin/lswsctrl restart"
restart_needed=false

# Dosya yollarını tanımla
htaccessfilelastmodifpath="$script_dir/Variables/htaccessFileList.txt"
time_file="$script_dir/Variables/htaccessFileCronTime.txt"

# Şu anki zamanı al
current_time=$(date +%s)

# time.txt dosyası yoksa oluştur ve eski bir zaman değeri koy
if [ ! -f "$time_file" ]; then
    echo 0 > "$time_file"
    restart_needed=true
fi

# time.txt dosyasından son çalıştırma zamanını oku
last_run_time=$(cat "$time_file")

# Farkı hesapla (saniye cinsinden)
time_diff=$((current_time - last_run_time))

# Eğer son çalıştırmadan beri 3600 saniyeden fazla geçmişse (1 saat)
if [ $time_diff -ge 3600 ]; then
    # time.txt dosyasını güncelle
    echo $current_time > "$time_file"

    # .htaccess dosyalarının son değişiklik tarihlerini güncelle
    > "$htaccessfilelastmodifpath"
    find /www/wwwroot/ -name ".htaccess" | while IFS= read -r file; do
        if [ -f "$file" ]; then
            # Dosyanın son değişiklik zamanını al (int formatında)
            last_modified=$(stat -c %Y "$file")
            echo "$file#$last_modified" >> "$htaccessfilelastmodifpath"
        fi
    done
    
    echo "Htaccess file modification times updated!"
else
    echo "Waiting for the next run."
fi


# Dosya yollarının bulunduğu ve son değişiklik zamanlarının saklandığı dosyaları kontrol et
if [ -f "$htaccessfilelastmodifpath" ]; then
    while IFS='#' read -r file last_modified; do
        if [ -f "$file" ]; then
            # Dosyanın son değişiklik zamanını al
            file_last_modified=$(stat -c %Y "$file")

            # Eğer dosyanın değişiklik tarihi kayıtlı tarihten farklıysa
            if [ "$file_last_modified" -gt "$last_modified" ]; then
                restart_needed=true
                break
            fi
        fi
    done < "$htaccessfilelastmodifpath"
fi

# Eğer yeniden başlatma gerekiyorsa
if [ "$restart_needed" = true ]; then
    echo "Changes detected. Restarting LightSpeed Web Server..."

    # htaccessFileCronTime.txt dosyasının içeriğini '0' olarak güncelle
    echo "0" > "$time_file"
    
    # LightSpeed Web Server'ı yeniden başlat
    #$lsws_restart_cmd
else
    echo "No changes detected. No restart needed."
fi