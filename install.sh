service=tamanegi-harvest


systemctl is-enabled $service.timer
if [ $? -eq 0 ]; then
  systemctl stop $service.timer
fi


cp ./tamanegi-harvest.sh /opt/tamanegi-harvest/
chmod +x /opt/tamanegi-harvest/tamanegi-harvest.sh



tee /usr/lib/systemd/system/${service}.service << EOS
[Unit]
Description=tamanegi-harvest
[Service]
Restart=always
ExecStart=/opt/tamanegi-harvest/tamanegi-harvest.sh
Type=simple
[Install]
WantedBy=default.target
EOS

tee /usr/lib/systemd/system/${service}.timer << EOS
[Unit]
Description=tamanegi-harvest timer

[Timer]
OnCalendar=*-*-* 12:00:00
Persistent=True

[Install]
WantedBy=timers.target


EOS


systemctl daemon-reload
systemctl enable $service.timer
systemctl start $service.timer


