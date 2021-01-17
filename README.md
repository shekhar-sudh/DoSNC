# DoSNC
DoSNC Utility - Automated SNC-SSO Implementation & Management for the SAP Systems	
(Note - This project utilizes the Venafi API for the servicing certificates for the SAP system PSE from the Venafi CA. With a little modification we can reuse the code for any other CA & its provided API)
				
Option 01	- Implementation of the SNC on the SAP System for the first time using the DoSNC Utility.			
	1	Manual Task	Validate that there is no PSE present in SAP SNC Cryptolib - via STRUSTSSO2.	
	2	Automated via DoSNC	Run DoSNC with ENROLL option - e.g. - "./DoSNC ENROLL ABAP D00". DoSNC utility will perform following tasks for you -	
			a. Create the SAPSNCS.pse in the instance SECUDIR.	
			b. Generate the Certificate Signing Request (CSR) for the SAPSNCS.pse	
			c. Enroll the SNC certificate into Venafi Trust Protection Platform.	
			d. Download the Venafi CA signed certificate with company Root certificate in the certificate chain.	
			e. Import the Venafi signed certificate in the SAPSNCS.pse	
			f. Import the SLS Root Certificate in the SAPSNCS.pse	
			g. Create the SECLOGIN credential for the sidadm user.	
			h. Append the security, SNC/SPNEGO parameters in the DEFAULT.PFL	
			i. Send a mail copy of the SAPSNCS.pse to the team	
	3	Manual Task	Restart the SAP system for Security, SNC/SPNEGO parameters & the SAPSNCS.pse from SECUDIR to take effect.	
	4	Manual Task	Login using SNC - it should already be working now with the SNC PSE.	
	5	Manual Task	Import the SAPSNCS.pse file in SAP SNC Cryptolib - via STRUSTSSO2.	

Option 02 - 	Renewal of the SNC implementation on the SAP System using the DoSNC Utility.			
	1	Manual Task	Delete the expiring SNC PSE present in SAP SNC Cryptolib - via STRUSTSSO2.	
	2	Automated via DoSNC	Run DoSNC with RENEW option - e.g. - "./DoSNC RENEW ABAP D00". DoSNC utility will perform following tasks for you -	
			a. Create the new SAPSNCS.pse in the instance SECUDIR.	
			b. Generate the new Certificate Signing Request (CSR) for the SAPSNCS.pse	
			c. Enroll the new SNC certificate into Venafi Trust Protection Platform.	
			d. Download the new Venafi CA signed certificate with company Root certificate in the certificate chain.	
			e. Import the new Venafi signed certificate in the new SAPSNCS.pse	
			f. Import the SLS Root Certificate in the new SAPSNCS.pse	
			g. Create the new SECLOGIN credential for the sidadm user.	
			h. Delete the old security, SNC/SPNEGO parameters in the DEFAULT.PFL, and append the new security, SNC/SPNEGO parameters in the DEFAULT.PFL	
			i. Send a mail copy of the new SAPSNCS.pse to the team	
			j. Revoke the old SNC certificate from the Venafi Trust Protection Platform.	
	3	Manual Task	Login using SNC - it should already be working now with the new SNC PSE.	
	4	Manual Task	"Import the SAPSNCS.pse file in SAP SNC Cryptolib - via STRUSTSSO2. Since it is just renewal, and there is no parameter changes, 
there should not be any need of the SAP system restart."	
