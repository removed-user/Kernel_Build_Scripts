#!/usr/bin/env bash
(
eval \
{
curl -s https://www.kernel.org/finger_banner > /tmp/kver
sed -n '1,2p; 4p' /tmp/kver | awk -F ' ' '{print $3"=" $NF}' |\
sed -e 's#=#&"#g' -e 's#$#"#g'
}
)
