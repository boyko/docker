#!/usr/bin/execlineb -P

with-contenv
multisubstitute
{
  import -i DOMAINS
}
confd --onetime -backend env
