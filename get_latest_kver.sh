#!/usr/bin/env bash
{
curl -s https://www.kernel.org/finger_banner > /tmp/kver
sed -n '1,2p; 4p' /tmp/kver | awk -F ' ' '{print $3 ":\n\t" $NF}' |\
sed -e 's#=#&"#g' -e 's#$#"#g'
}
