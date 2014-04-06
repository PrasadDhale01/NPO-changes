How to setup Jetty SSL.

1. Obtain SSL certificate from a certificate providing company.
In this case the certificate was bought from namecheap.com.
Files downloaded from namecheap.com are in the folder "./namecheap"

2. Download the corresponding private key.
In this case the private key was created on bluehost.com.
The private key downloaded from bluehost.com is in the folder "./bluehost"

3. Install PositiveSSL on Jetty
NOTE: These steps are from http://www.grobmeier.de/installing-comodo-positivessl-on-jetty-12112012.html#.U0Gtmq1dU5Y

3a. Create a cert chain for the certificate files downloaded from namecheap:
$ cat ./namecheap/beta_fedu_org.crt ./namecheap/PositiveSSLCA2.crt ./namecheap/AddTrustExternalCARoot.crt cert-chain.txt

3b. Create a PKCS12 file
$ openssl pkcs12 -export -inkey ./bluehost/beta_fedu_org.private.key -in cert-chain.txt -out beta_fedu_org.jetty.pkcs12

3c. Create a keystore file
$ keytool -importkeystore -srckeystore beta_fedu_org.jetty.pkcs12 -srcstoretype PKCS12 -destkeystore beta_fedu_org.keystore.jks

4. Copy the keystore (jks) file to Jetty
$ cp beta_fedu_org.keystore.jks $JETTY_HOME/etc/beta_fedu_org.keystore.jks

5. Edit jetty-ssl.xml (update the following lines to point to the new keystore file).
NOTE: The password is "password" for all private keys in this cases.
NOTE: OBF:1v2j1uum1xtv1zej1zer1xtn1uvk1v1v is the encrypted equivalent for password "password"

$ vim $JETTY_HOME/etc/jetty-ssl.xml
  <Set name="KeyStorePath"><Property name="jetty.base" default="." />/<Property name="jetty.keystore" default="etc/beta_fedu_org.keystore.jks"/></Set>
  <Set name="KeyStorePassword"><Property name="jetty.keystore.password" default="OBF:1v2j1uum1xtv1zej1zer1xtn1uvk1v1v"/></Set>
  <Set name="KeyManagerPassword"><Property name="jetty.keymanager.password" default="OBF:1v2j1uum1xtv1zej1zer1xtn1uvk1v1v"/></Set>
  <Set name="TrustStorePath"><Property name="jetty.base" default="." />/<Property name="jetty.truststore" default="etc/beta_fedu_org.keystore.jks"/></Set>
  <Set name="TrustStorePassword"><Property name="jetty.truststore.password" default="OBF:1v2j1uum1xtv1zej1zer1xtn1uvk1v1v"/></Set>

6. Change default port from 443 to 8443
NOTE: Without this change there will be a permission error at startup since in non-sudo mode jetty cannot bind to 443
NOTE: Separately a port forward of 443 to 8443 should be done (see setup-ubuntu.txt file)

$ vim $JETTY_HOME/etc/jetty-https.xml
          <Set name="port"><Property name="https.port" default="8443" /></Set>

7. Start Jetty with https module as follows:
$ java -jar start.jar --module=https,deploy

