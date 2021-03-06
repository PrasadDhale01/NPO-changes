dataSource {
    pooled = true
    jmxExport = true
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
//    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
}

// environment specific settings
environments {
    development {
        dataSource {
            // H2
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:h2:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
            // url = "jdbc:h2:mem:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
            driverClassName = "org.h2.Driver"
            username = "sa"
            password = ""

            // MySQL

            /*dbCreate = "update"
            url = "jdbc:mysql://localhost:3306/crowderadbdev"
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
            username = 'crowderadbmaster'
            password = 'crowderadbpass'*/
            
        }
    }
    test {
       dataSource {
		dbCreate = "update"
            url = "jdbc:mysql://crowderadb-test.c5qkqnx9x4ca.us-west-2.rds.amazonaws.com:3306/crowderadbtest?zeroDateTimeBehavior=convertToNull"
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"

            username = 'crowderadbmaster'
            password = 'crowderadbpass'

            properties {
                // Documentation for Tomcat JDBC Pool
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Common_Attributes
                // https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/tomcat/jdbc/pool/PoolConfiguration.html
                jmxEnabled = true
                initialSize = 5
                maxActive = 50
                minIdle = 5
                maxIdle = 25
                maxWait = 10000
                maxAge = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis = 60000
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                ignoreExceptionOnPreLoad = true
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#JDBC_interceptors
                jdbcInterceptors = "ConnectionState;StatementCache(max=200)"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED // safe default
                // controls for leaked connections
                abandonWhenPercentageFull = 100 // settings are active only when pool is full
                removeAbandonedTimeout = 120000
                removeAbandoned = true
                // use JMX console to change this setting at runtime
                logAbandoned = false // causes stacktrace recording overhead, use only for debugging
                /*
                // JDBC driver properties
                // Mysql as example
                dbProperties {
                    // Mysql specific driver properties
                    // http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html
                    // let Tomcat JDBC Pool handle reconnecting
                    autoReconnect=false
                    // truncation behaviour
                    jdbcCompliantTruncation=false
                    // mysql 0-date conversion
                    zeroDateTimeBehavior='convertToNull'
                    // Tomcat JDBC Pool's StatementCache is used instead, so disable mysql driver's cache
                    cachePrepStmts=false
                    cacheCallableStmts=false
                    // Tomcat JDBC Pool's StatementFinalizer keeps track
                    dontTrackOpenResources=true
                    // performance optimization: reduce number of SQLExceptions thrown in mysql driver code
                    holdResultsOpenOverStatementClose=true
                    // enable MySQL query cache - using server prep stmts will disable query caching
                    useServerPrepStmts=false
                    // metadata caching
                    cacheServerConfiguration=true
                    cacheResultSetMetadata=true
                    metadataCacheSize=100
                    // timeouts for TCP/IP
                    connectTimeout=15000
                    socketTimeout=120000
                    // timer tuning (disable)
                    maintainTimeStats=false
                    enableQueryTimeouts=false
                    // misc tuning
                    noDatetimeStringSync=true
                }
                */
            }
        }
    }
    staging {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://crowderadb.c5qkqnx9x4ca.us-west-2.rds.amazonaws.com:3306/crowderadb?zeroDateTimeBehavior=convertToNull"
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"

            username = 'crowderadbmaster'
            password = 'crowderadbpass'

            properties {
                // Documentation for Tomcat JDBC Pool
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Common_Attributes
                // https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/tomcat/jdbc/pool/PoolConfiguration.html
                jmxEnabled = true
                initialSize = 5
                maxActive = 50
                minIdle = 5
                maxIdle = 25
                maxWait = 10000
                maxAge = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis = 60000
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                ignoreExceptionOnPreLoad = true
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#JDBC_interceptors
                jdbcInterceptors = "ConnectionState;StatementCache(max=200)"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED // safe default
                // controls for leaked connections
                abandonWhenPercentageFull = 100 // settings are active only when pool is full
                removeAbandonedTimeout = 120000
                removeAbandoned = true
                // use JMX console to change this setting at runtime
                logAbandoned = false // causes stacktrace recording overhead, use only for debugging
                /*
                // JDBC driver properties
                // Mysql as example
                dbProperties {
                    // Mysql specific driver properties
                    // http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html
                    // let Tomcat JDBC Pool handle reconnecting
                    autoReconnect=false
                    // truncation behaviour
                    jdbcCompliantTruncation=false
                    // mysql 0-date conversion
                    zeroDateTimeBehavior='convertToNull'
                    // Tomcat JDBC Pool's StatementCache is used instead, so disable mysql driver's cache
                    cachePrepStmts=false
                    cacheCallableStmts=false
                    // Tomcat JDBC Pool's StatementFinalizer keeps track
                    dontTrackOpenResources=true
                    // performance optimization: reduce number of SQLExceptions thrown in mysql driver code
                    holdResultsOpenOverStatementClose=true
                    // enable MySQL query cache - using server prep stmts will disable query caching
                    useServerPrepStmts=false
                    // metadata caching
                    cacheServerConfiguration=true
                    cacheResultSetMetadata=true
                    metadataCacheSize=100
                    // timeouts for TCP/IP
                    connectTimeout=15000
                    socketTimeout=120000
                    // timer tuning (disable)
                    maintainTimeStats=false
                    enableQueryTimeouts=false
                    // misc tuning
                    noDatetimeStringSync=true
                }
                */
            }
        }
    }

    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://crowderadb.c5qkqnx9x4ca.us-west-2.rds.amazonaws.com:3306/crowderadb?zeroDateTimeBehavior=convertToNull"
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"

            username = 'crowderadbmaster'
            password = 'crowderadbpass'

            properties {
               // Documentation for Tomcat JDBC Pool
               // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Common_Attributes
               // https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/tomcat/jdbc/pool/PoolConfiguration.html
               jmxEnabled = true
               initialSize = 5
               maxActive = 50
               minIdle = 5
               maxIdle = 25
               maxWait = 10000
               maxAge = 10 * 60000
               timeBetweenEvictionRunsMillis = 5000
               minEvictableIdleTimeMillis = 60000
               validationQuery = "SELECT 1"
               validationQueryTimeout = 3
               validationInterval = 15000
               testOnBorrow = true
               testWhileIdle = true
               testOnReturn = false
               ignoreExceptionOnPreLoad = true
               // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#JDBC_interceptors
               jdbcInterceptors = "ConnectionState;StatementCache(max=200)"
               defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED // safe default
               // controls for leaked connections
               abandonWhenPercentageFull = 100 // settings are active only when pool is full
               removeAbandonedTimeout = 120000
               removeAbandoned = true
               // use JMX console to change this setting at runtime
               logAbandoned = false // causes stacktrace recording overhead, use only for debugging
               /*
               // JDBC driver properties
               // Mysql as example
               dbProperties {
                   // Mysql specific driver properties
                   // http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html
                   // let Tomcat JDBC Pool handle reconnecting
                   autoReconnect=false
                   // truncation behaviour
                   jdbcCompliantTruncation=false
                   // mysql 0-date conversion
                   zeroDateTimeBehavior='convertToNull'
                   // Tomcat JDBC Pool's StatementCache is used instead, so disable mysql driver's cache
                   cachePrepStmts=false
                   cacheCallableStmts=false
                   // Tomcat JDBC Pool's StatementFinalizer keeps track
                   dontTrackOpenResources=true
                   // performance optimization: reduce number of SQLExceptions thrown in mysql driver code
                   holdResultsOpenOverStatementClose=true
                   // enable MySQL query cache - using server prep stmts will disable query caching
                   useServerPrepStmts=false
                   // metadata caching
                   cacheServerConfiguration=true
                   cacheResultSetMetadata=true
                   metadataCacheSize=100
                   // timeouts for TCP/IP
                   connectTimeout=15000
                   socketTimeout=120000
                   // timer tuning (disable)
                   maintainTimeStats=false
                   enableQueryTimeouts=false
                   // misc tuning
                   noDatetimeStringSync=true
               }
               */
            }
        }
    }
	
	testIndia {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://crowderadb-test.c5qkqnx9x4ca.us-west-2.rds.amazonaws.com:3306/crowderadbtest?zeroDateTimeBehavior=convertToNull"
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"

            username = 'crowderadbmaster'
            password = 'crowderadbpass'

            properties {
                // Documentation for Tomcat JDBC Pool
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Common_Attributes
                // https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/tomcat/jdbc/pool/PoolConfiguration.html
                jmxEnabled = true
                initialSize = 5
                maxActive = 50
                minIdle = 5
                maxIdle = 25
                maxWait = 10000
                maxAge = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis = 60000
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                ignoreExceptionOnPreLoad = true
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#JDBC_interceptors
                jdbcInterceptors = "ConnectionState;StatementCache(max=200)"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED // safe default
                // controls for leaked connections
                abandonWhenPercentageFull = 100 // settings are active only when pool is full
                removeAbandonedTimeout = 120000
                removeAbandoned = true
                // use JMX console to change this setting at runtime
                logAbandoned = false // causes stacktrace recording overhead, use only for debugging
                /*
                // JDBC driver properties
                // Mysql as example
                dbProperties {
                    // Mysql specific driver properties
                    // http://dev.mysql.com/doc/connector-j/en/connector-j-reference-configuration-properties.html
                    // let Tomcat JDBC Pool handle reconnecting
                    autoReconnect=false
                    // truncation behaviour
                    jdbcCompliantTruncation=false
                    // mysql 0-date conversion
                    zeroDateTimeBehavior='convertToNull'
                    // Tomcat JDBC Pool's StatementCache is used instead, so disable mysql driver's cache
                    cachePrepStmts=false
                    cacheCallableStmts=false
                    // Tomcat JDBC Pool's StatementFinalizer keeps track
                    dontTrackOpenResources=true
                    // performance optimization: reduce number of SQLExceptions thrown in mysql driver code
                    holdResultsOpenOverStatementClose=true
                    // enable MySQL query cache - using server prep stmts will disable query caching
                    useServerPrepStmts=false
                    // metadata caching
                    cacheServerConfiguration=true
                    cacheResultSetMetadata=true
                    metadataCacheSize=100
                    // timeouts for TCP/IP
                    connectTimeout=15000
                    socketTimeout=120000
                    // timer tuning (disable)
                    maintainTimeStats=false
                    enableQueryTimeouts=false
                    // misc tuning
                    noDatetimeStringSync=true
                }
                */
            }
        }
    }
	
    stagingIndia {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://crowderadb.c5qkqnx9x4ca.us-west-2.rds.amazonaws.com:3306/crowderadb?zeroDateTimeBehavior=convertToNull"
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"

            username = 'crowderadbmaster'
            password = 'crowderadbpass'

            properties {
                // Documentation for Tomcat JDBC Pool
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Common_Attributes
                // https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/tomcat/jdbc/pool/PoolConfiguration.html
                jmxEnabled = true
                initialSize = 5
                maxActive = 50
                minIdle = 5
                maxIdle = 25
                maxWait = 10000
                maxAge = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis = 60000
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                ignoreExceptionOnPreLoad = true
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#JDBC_interceptors
                jdbcInterceptors = "ConnectionState;StatementCache(max=200)"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED // safe default
                // controls for leaked connections
                abandonWhenPercentageFull = 100 // settings are active only when pool is full
                removeAbandonedTimeout = 120000
                removeAbandoned = true
                // use JMX console to change this setting at runtime
                logAbandoned = false // causes stacktrace recording overhead, use only for debugging
                
		    }
	    }
    }

    prodIndia {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://crowderadb.c5qkqnx9x4ca.us-west-2.rds.amazonaws.com:3306/crowderadb?zeroDateTimeBehavior=convertToNull"
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"

            username = 'crowderadbmaster'
            password = 'crowderadbpass'

            properties {
                // Documentation for Tomcat JDBC Pool
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#Common_Attributes
                // https://tomcat.apache.org/tomcat-7.0-doc/api/org/apache/tomcat/jdbc/pool/PoolConfiguration.html
                jmxEnabled = true
                initialSize = 5
                maxActive = 50
                minIdle = 5
                maxIdle = 25
                maxWait = 10000
                maxAge = 10 * 60000
                timeBetweenEvictionRunsMillis = 5000
                minEvictableIdleTimeMillis = 60000
                validationQuery = "SELECT 1"
                validationQueryTimeout = 3
                validationInterval = 15000
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = false
                ignoreExceptionOnPreLoad = true
                // http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html#JDBC_interceptors
                jdbcInterceptors = "ConnectionState;StatementCache(max=200)"
                defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED // safe default
                // controls for leaked connections
                abandonWhenPercentageFull = 100 // settings are active only when pool is full
                removeAbandonedTimeout = 120000
                removeAbandoned = true
                // use JMX console to change this setting at runtime
                logAbandoned = false // causes stacktrace recording overhead, use only for debugging
            }
        }
    }
	
}
