
workspace {
    model {
        personalIGCustomer = person "Personnal Instagram Customer" "An user of the instagram, with personal instagram account."
        
        enterprise "IG System" {            
            mainframeIGSystem = softwareSystem "Mainframe Instagram System" "Stores all of the core Instagram information about users, accounts, activities."    
            
            internetIGSystem = softwareSystem "Internet Instagram System" "Allow user to view infomation about their Instagram accounts, and make interact with peoples" {
                webApplication = container "Web Application" "Delivers the static content and the Internet Instagram single page application." "Dotnet core and 'Repoitory Pattern'" 
                mobileApp = container "Mobile App" "Provides a limited subset of the Internet Instagram functionality to customers via their mobile device." "Reactjs"
                singlePageApplication = container "Single-Page Application" "Provides all of the internet instagram functionality and implementation that load only a single web browser" "JavaScript and Reactjs"
                apiApplication = container "API Application" "Provides application infomation and functionality via a JSON/HTTPS API" "Dotnet core and the repository"
                database = container "Database" "Stores user registation infomation, access log, etc." "Sql server" "Database"
            }
        }

        # relationships between person and software systems
        personalIGCustomer -> internetIGSystem "Uses"
        internetIGSystem -> mainframeIGSystem "Gets account information from, and make activities using"

        # realationships to/from containers 
        personalIGCustomer -> webApplication "Visits instagram.com using" "HTTPS"
        personalIGCustomer -> mobileApp "Views account infomation and make activities using"
        personalIGCustomer -> singlePageApplication "Views account infomation and make activities using"
        apiApplication -> database "Reads from and writes to" "Framework Entity" 
        singlePageApplication -> apiApplication "Makes API calls to" "JSON/HTTPS"
        mobileApp -> apiApplication "Makes API calls to" "JSON/HTTPS"
        apiApplication -> mainframeIGSystem "Makes API calls to" "XML/HTTPS"

    }
    views {
        systemContext internetIGSystem "IGSystemContext" {
            include * 
            animation {
                personalIGCustomer
                internetIGSystem
                mainframeIGSystem
            }
            autoLayout
        }

        container internetIGSystem "IGContainers" {
            include * 
            animation {
                personalIGCustomer
                webApplication
                mobileApp
                singlePageApplication
                apiApplication
                database
            }
            autoLayout
        }

        styles {
            element "SoftwareSystem" {
                background #1168bd
                color #ffffff
            }
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
        }
    }
}

