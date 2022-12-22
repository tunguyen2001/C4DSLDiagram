
workspace {
    model {
        InstagramUser = person "Instagram User" "An user of the instagram, with personal instagram account."
        LinkedFBUser = person "Linked FB User" "Use instagram with facebook account"

        enterprise "IG System" {            
            Facebook = softwareSystem "Facebook" "some functions to share and interact between the two systems" "Facebook"
            
            InstagramSystem = softwareSystem "Instagram System" "Allow user to view infomation about their Instagram accounts, activities interact posts and make interact with peoples" {
                webApplication = container "Web Application" "Delivers the static content and the Internet Instagram single page application." "Dotnet core and 'Repoitory Pattern'" "WebBrowser"
                mobileApp = container "Mobile App" "Provides a limited subset of the Internet Instagram functionality to customers via their mobile device." "Reactjs" "MobileApp"
                singlePageApplication = container "Single-Page Application" "Provides all of the internet instagram functionality and implementation that load only a single web browser" "JavaScript and Reactjs" "singlePageApplication"
                database = container "Database" "Stores user registation infomation, access log, etc." "Sql server" "Database"

                apiApplication = container "API Application" "Provides application infomation and functionality via a JSON/HTTPS API" "Dotnet core and 'Repository Pattern'" "apiApplication" {
                    controller = component "Controller" "directional, Provides an api interface, allowing users to use system functionality" "Dotnet core controller"
                    service = component "Service" "connection between controller and repository, operations do not interact with database" "Dotnet Core - Framework entity"
                    baseRepository = component "Base Repository" "base class, interface with the method and functions used general" "Repository Pattern"
                    repository = component "Repository" "Direct interaction with the database, CRUD" "Framework Entity(LinQ) - 'repository pattern'"
                    entity = component "Entity" "Provider info entity, direct relationship with database" "framework Entity"
                    authorizitionPosts = component "Authorizition Posts" "Post permissions, functions for post owners and limited to followers/viewers" "Dotnet core - Json Web Token"
                    authorizitionProfile = component "Authorizition Profile" "Assign user permissions to profile, public or private" "Dotnet core - Json web token" 
                    facebookConnector = component "Facebook Connector" "Request - check authentication, approve permission and accept token" "Dotnet Core - JS/Json"

                }
                
            }
        } 

        # relationships between person and software systems
        InstagramUser -> InstagramSystem "Uses"
        LinkedFBUser -> InstagramSystem "Uses"
        InstagramSystem -> Facebook "share and interact"
        
        
        # realationships to/from containers 
        InstagramUser -> webApplication "Visits instagram.com using" "HTTPS"
        InstagramUser -> mobileApp "Views account infomation and make activities using"
        InstagramUser -> singlePageApplication "Views account infomation and make activities using"

        LinkedFBUser -> webApplication "Visits instagram.com using" "HTTPS"
        LinkedFBUser -> mobileApp "Views account infomation and make activities using"
        LinkedFBUser -> singlePageApplication "Views account infomation and make activities using"

        apiApplication -> database "Reads from and writes to" "Framework Entity" 
        singlePageApplication -> apiApplication "Makes API calls to" "JSON/HTTPS"
        webApplication -> singlePageApplication "Deliver to the user web browser"
        mobileApp -> apiApplication "Makes API calls to" "JSON/HTTPS"
        apiApplication -> Facebook "Access token and Call to HTTPs to share stories"


        # relationships of component - API Application
        singlePageApplication -> controller "Make API call to" "Json/HTTPs"
        mobileApp -> controller "Make API call to" "Json/HTTPs"
        controller -> service "Uses"
        service -> repository "Uses"
        service -> facebookConnector "Uses"
        facebookConnector -> Facebook "Share information stories and other to" "HTTPs"
        baseRepository -> repository "Extends"
        repository -> entity "Uses"
        repository -> database "Read from and write to" "Framwork Entity"
        entity -> database "Mapping" "Framework Entity"
        controller -> authorizitionPosts "Uses"
        controller -> authorizitionProfile "Uses"
        authorizitionPosts -> entity "Uses"
        authorizitionProfile -> entity "Uses"
        
    }
    views {
        systemContext InstagramSystem "IGSystemContext" {
            include * 
            animation {
            }
            autoLayout
        }

        container InstagramSystem "ContainersIGSystem" {
            include * 
            animation {
            }
            autoLayout
        }

        component apiApplication "ComponentApiApplication" {
            include *
            animation {

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
            element "Facebook" {
                background #2caff5
                color #ffffff
            }
            element "MobileApp" {
                shape MobileDevicePortrait
                background #0ed7e6
            }
            element "WebBrowser" {
                shape WebBrowser
                background #0ed7e6
            }
            element "singlePageApplication" {
                background #0ed7e6
            }
            element "apiApplication" {
                background #0ed7e6 
            }
            element "Database" {
                shape Cylinder
                background #1168bd
                color #ffffff
            }
        }
    }
}


// Share with fb : 
// 1: Client requests access and permissions via SDK and login Dialog
// 2: User authenticates and approves permission
// 3: Access token is returned to client 

