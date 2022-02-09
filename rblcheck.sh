# The shell will strip multiple whitespace
allip='
x
y
z
	'
# Check if an IP address is listed on one of the following blacklists
BLISTS="
bl.spamcop.net
cbl.abuseat.org
b.barracudacentral.org
dnsbl.sorbs.net
http.dnsbl.sorbs.net
dul.dnsbl.sorbs.net
misc.dnsbl.sorbs.net
smtp.dnsbl.sorbs.net
socks.dnsbl.sorbs.net
spam.dnsbl.sorbs.net
web.dnsbl.sorbs.net
zombie.dnsbl.sorbs.net
pbl.spamhaus.org
sbl.spamhaus.org
xbl.spamhaus.org
zen.spamhaus.org
psbl.surriel.com
ubl.unsubscore.com
rbl.spamlab.com
dyna.spamrats.com
noptr.spamrats.com
spam.spamrats.com
cbl.anti-spam.org.cn
cdl.anti-spam.org.cn
dnsbl.inps.de
drone.abuse.ch
httpbl.abuse.ch
korea.services.net
short.rbl.jp
virus.rbl.jp
spamrbl.imp.ch
wormrbl.imp.ch
virbl.bit.nl
rbl.suresupport.com
dsn.rfc-ignorant.org
spamguard.leadmon.net
opm.tornevall.org
netblock.pedantic.org
multi.surbl.org
ix.dnsbl.manitu.net
tor.dan.me.uk
rbl.efnetrbl.org
relays.mail-abuse.org
blackholes.mail-abuse.org
rbl-plus.mail-abuse.org
dnsbl.dronebl.org
access.redhawk.org
db.wpbl.info
rbl.interserver.net
query.senderbase.org
bogons.cymru.com
csi.cloudmark.com
truncate.gbudb.net		
"

# Loop trough all IPs
for ip in $allip ; do
	# Reverse the IP
	reverse=$(echo $ip | sed -ne "s~^\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)$~\4.\3.\2.\1~p")
	# Loop trough all Blacklists with reversed IP
	for BL in ${BLISTS} ; do
	    # Print the date (without linefeed)
	    printf $(env TZ='Europe/Berlin' date "+%d-%m-%Y %H:%M")
	    # Show the IP and the name of the blacklist
	    printf "%-40s" " IP $ip | Blacklist http://${BL} "
	    # Use dig to lookup the name in the blacklist
	    LISTED="$(dig +short -t a ${reverse}.${BL}.)" 
	    echo ${LISTED:----} 

	done
done
