//: Playground - noun: a place where people can play

import Foundation

fileprivate protocol EndPointConfigurationType {
   static var baseAPI : String { get }
}

fileprivate struct EndPointProduction: EndPointConfigurationType  {
   static var baseAPI: String {
      return "https://jsonplaceholder.typicode.com/"
   }
}

fileprivate struct EndPointDevelopment: EndPointConfigurationType {
   static var baseAPI: String {
      return "https://testing.com/"
   }
}


fileprivate struct EndPointConfigurationFactory<T:EndPointConfigurationType> {
   
   private static var currentEndPoint: String {
      return T.baseAPI
   }
   
   static var active: String {
      return currentEndPoint
   }
}

fileprivate protocol EndPointConfigurationActiveType {
   static var active: String! { get set }
}

fileprivate enum EndPointConfiguration {
   
   case development
   case production

   var active: String {
      switch self {
      case .development:
         return EndPointConfigurationFactory<EndPointDevelopment>.active
         
      case .production:
         return EndPointConfigurationFactory<EndPointProduction>.active
      }
      
   }
   
}


// EndPoint Manager

struct EndPoint: EndPointConfigurationActiveType {
   fileprivate typealias me = EndPoint
   fileprivate static var active: String!
}


// Post Directory
extension EndPoint {
   public enum Post: String {
      case get
      case update
      case delete
      
      var value: String {
         switch self {
         case .get:
            return me.active + "posts"
         case .delete:
            return me.active + "delete"
         case .update:
            return me.active + "update"
         }
      }
   }
}

// User Directory
extension EndPoint {
   
   public enum User: String {
      case login
      case logout
      case update
      case delete
      case get
      
      var value: String {
         switch self {
         case .login:
            return me.active + "login"
         case .logout:
            return me.active + "logout"
         case .update:
            return me.active + "update"
         case .delete:
            return me.active + "delete"
         case .get:
            return me.active + "get"
         }
      }
   }
}



// Configuration

EndPoint.active = EndPointConfiguration.production.active



// Usage of post
EndPoint.Post.delete.value
EndPoint.Post.get.value
EndPoint.Post.update.value



// Usage of user
EndPoint.User.login.value
EndPoint.User.logout.value
EndPoint.User.delete.value
EndPoint.User.update.value
EndPoint.User.get.value

