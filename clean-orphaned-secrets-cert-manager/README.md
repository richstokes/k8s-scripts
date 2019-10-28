Script to clean up/fix this issue  


`"unable to fetch certificate that owns the secret"`  

This script will find TLS secrets in a given namespace which have no matching certificate resource and delete them.  

&nbsp;

#### Usage
`./clean-orphans.sh <namespace>`  

Specifying no namespace will check the default. You will be prompted before anything is deleted.  
