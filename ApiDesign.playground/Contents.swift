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

struct EndPoint: EndPointConfigurationActiveType {
   
   fileprivate typealias me = EndPoint
   
   fileprivate static var active: String!
   
   public enum Post: String {
      case getPost
      
      public var value: String {
         switch self {
         case .getPost:
            return me.active + "posts"
         }
      }
   }
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


// Configuration

EndPoint.active = EndPointConfiguration.development.active


EndPoint.Post.getPost.value


// Usage
EndPoint.Post.getPost.value

