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
