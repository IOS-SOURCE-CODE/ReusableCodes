//: Playground - noun: a place where people can play

import Foundation

public protocol EndPointConfigurationType {
   static var baseAPI : String { get }
}


struct EndPointProduction: EndPointConfigurationType  {
   static var baseAPI: String {
      return "https://jsonplaceholder.typicode.com/"
   }
}

struct EndPointTesting: EndPointConfigurationType {
   static var baseAPI: String {
      return "https://testing.com"
   }
}


fileprivate struct EndPointConfigurationFactory<T:EndPointConfigurationType> {
   
   private static var currentEndPoint: String {
      return T.baseAPI
   }
   
   static var baseAPI: String {
      return currentEndPoint
   }
}


public struct EndPoint {
   
   fileprivate typealias me = EndPoint
   
   private static let baseAPI = EndPointConfigurationFactory<EndPointConfiguration>.baseAPI
   
   public enum Post: String {
      case getPost
      
      public var value: String {
         switch self {
         case .getPost:
            return me.baseAPI + "posts"
         }
      }
   }
}


struct Box<T:EndPointConfigurationType> {
   
   static var value: T.Type {
      return T.self
   }
}

enum EndPointType {
   case production
   case development
   
   var value: EndPointConfigurationType.Type {
      switch self {
      case .production:
            return EndPointProduction.self
         
      case .development:
            return EndPointTesting.self
      }
   }
}

struct AllowConfigurationEndPoint {
   static var development: EndPointConfigurationType.Type {
      return EndPointTesting.self
   }
   
   static var production: EndPointConfigurationType.Type {
      return EndPointProduction.self
   }
}

typealias EndPointConfiguration = EndPointTesting



EndPoint.Post.getPost.value

