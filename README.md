<h2>Steps to setup on a Mac:</h2>
<ol>
    <li>
        git clone https://github.com/atreya/FEDU.git
    </li>
    <li>
        Install GVM (the Groovy enVironment Manager): http://gvmtool.net/
        <ul>
            <li>
                $ curl -s get.gvmtool.net | bash
            </li>
            <li>
                $ source ~/.gvm/bin/gvm-init.sh
            </li>
        </ul>
    </li>
    <li>
        Install Grails (2.3.6 at the time of writing)
        <ul>
            <li>
                $ gvm install grails
            </li>
        </ul>
    </li>
    <li>
        Run app
        <ul>
            <li>
                $ grails run-app
            </li>
        </ul>
    </li>
    <li>
        Test in browser @ http://localhost:8080/FEDU
    </li>
</ol>

<h2>MySQL instructions for Mac</h2>
To connect:
    mysql -uroot

To have launchd start mysql at login:
    ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
Then to load mysql now:
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
Or, if you don't want/need launchctl, you can just run:
    mysql.server start

