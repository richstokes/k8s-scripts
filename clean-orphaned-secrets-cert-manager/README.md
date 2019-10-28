Script to clean up/fix this issue  


`"unable to fetch certificate that owns the secret"` -- there seems to be no mechanism that deletes the old TLS secrets once the associated certificate is deleted. So you just end up with more and more “orphaned” secrets causing errors in the cert-manger logs.  

This script will find TLS secrets in a given namespace which have no matching certificate resource and delete them.  