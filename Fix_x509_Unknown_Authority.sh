#!/bin/bash
#******************************************************************************************************************************************
#This script will fix the following error for you -->
#vCert: <Date> <Time>  Unable to connect to TPP: Post https://ven.company.com/vedsdk/authorize/: x509: certificate signed by unknown authority
#******************************************************************************************************************************************
USER=`whoami`
if [[ ${USER} == root ]] ; then 
	REDHAT=`cat /proc/version | grep -i red | wc -l`
	SUSE=`cat /proc/version | grep -i suse | wc -l`
		if [[ ${REDHAT} -gt 0 && ${SUSE} = 0 ]] ; then
		   TYPE_SET=REDHAT
		   echo -e "\e[34mINFO:\e[0m Looks like this server is a ${TYPE_SET} LINUX"
		   echo -e "\e[34mINFO:\e[0m Let's fix the X509 issue now"
		   `cat ./Venafi_companyTLS-CA_base64.pem >> /etc/pki/tls/certs/ca-bundle.crt`
		   echo ""
		   echo "Done."
		   echo ""
		   echo -e "\e[34mINFO:\e[0m Now try re-running DoSNC & see if the error x509 certificate signed by unknown authority is gone."

		elif [[ ${SUSE} -gt 0 && ${REDHAT} = 0 ]] ; then
		   TYPE_SET=SUSE
		   echo -e "\e[34mINFO:\e[0m Looks like this server is a ${TYPE_SET} LINUX"
		   echo -e "\e[34mINFO:\e[0m Let's fix the X509 issue now"
		   `cp ./Venafi_companyTLS-CA_base64.pem /etc/pki/trust/anchors/`
		   `update-ca-certificates`
                   echo ""
		   echo "Done."
                   echo ""
		   echo -e "\e[34mINFO:\e[0m Now try re-running DoSNC & see if the error x509 certificate signed by unknown authority is gone."
		else
		   echo -e "\e[34mINFO:\e[0m Looks like this server has neither Redhat nor Suse but a different OS."
		   echo -e "\e[34mINFO:\e[0m Report to the Author - sudhanshu.shekhar@company.com."
		fi
else 
echo -e "\e[31m\e[5mError Condition:\e[0m Please run me as root user only."
fi
exit
####
