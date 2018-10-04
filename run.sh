echo "
# centralized history commands:
local1.notice                           /var/log/history.log" >> /etc/rsyslog.conf

echo "LOG_USER=\`who -m | awk '{print \$1;}'\`
SOURCEIP=\`who -m|cut -d')' -f1|cut -d'(' -f2\`
PROMPT_COMMAND='history 1 | logger -p local1.notice -t \"# SHELL: \$SHELL | LOGIN: \$LOG_USER | CURRENT_USER: \$USER[\$\$] | SSH_SOURCE_IP: 
\$SOURCEIP | INSTRUCTION\"'" > /etc/profile.d/sysloghistory.sh

echo "setenv LOG_USER \`who -m | awk '{print \$1;}'\`
setenv SOURCEIP \`who -m|cut -d')' -f1|cut -d'(' -f2\`
alias precmd \"history 1 | logger -p local1.notice -t 'SHELL \$SHELL | LOGIN \$LOG_USER | CURRENT_USER: \$USER[\$\$] | SSH_SOURCE_IP: \$SOURCEIP | INSTRUCTION'\" " > /etc/profile.d/sysloghistory.csh

service rsyslog restart 
