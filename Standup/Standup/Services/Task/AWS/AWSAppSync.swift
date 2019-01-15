//  This file was automatically generated and should not be edited.

import AWSAppSync

public struct CreateTaskInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID, title: String, status: TaskStatus, statusDate: String? = nil, order: Int) {
    graphQLMap = ["id": id, "title": title, "status": status, "statusDate": statusDate, "order": order]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var title: String {
    get {
      return graphQLMap["title"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }

  public var status: TaskStatus {
    get {
      return graphQLMap["status"] as! TaskStatus
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "status")
    }
  }

  public var statusDate: String? {
    get {
      return graphQLMap["statusDate"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "statusDate")
    }
  }

  public var order: Int {
    get {
      return graphQLMap["order"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "order")
    }
  }
}

public enum TaskStatus: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  public typealias RawValue = String
  case wip
  case done
  case todo
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "wip": self = .wip
      case "done": self = .done
      case "todo": self = .todo
      default: self = .unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .wip: return "wip"
      case .done: return "done"
      case .todo: return "todo"
      case .unknown(let value): return value
    }
  }

  public static func == (lhs: TaskStatus, rhs: TaskStatus) -> Bool {
    switch (lhs, rhs) {
      case (.wip, .wip): return true
      case (.done, .done): return true
      case (.todo, .todo): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public struct UpdateTaskInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID, title: String? = nil, status: TaskStatus? = nil, statusDate: String? = nil, order: Int) {
    graphQLMap = ["id": id, "title": title, "status": status, "statusDate": statusDate, "order": order]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var title: String? {
    get {
      return graphQLMap["title"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }

  public var status: TaskStatus? {
    get {
      return graphQLMap["status"] as! TaskStatus?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "status")
    }
  }

  public var statusDate: String? {
    get {
      return graphQLMap["statusDate"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "statusDate")
    }
  }

  public var order: Int {
    get {
      return graphQLMap["order"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "order")
    }
  }
}

public struct DeleteTaskInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID, order: Int) {
    graphQLMap = ["id": id, "order": order]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var order: Int {
    get {
      return graphQLMap["order"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "order")
    }
  }
}

public struct TableTaskFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: TableIDFilterInput? = nil, title: TableStringFilterInput? = nil, status: TableStringFilterInput? = nil, statusDate: TableStringFilterInput? = nil, order: TableIntFilterInput? = nil) {
    graphQLMap = ["id": id, "title": title, "status": status, "statusDate": statusDate, "order": order]
  }

  public var id: TableIDFilterInput? {
    get {
      return graphQLMap["id"] as! TableIDFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var title: TableStringFilterInput? {
    get {
      return graphQLMap["title"] as! TableStringFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "title")
    }
  }

  public var status: TableStringFilterInput? {
    get {
      return graphQLMap["status"] as! TableStringFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "status")
    }
  }

  public var statusDate: TableStringFilterInput? {
    get {
      return graphQLMap["statusDate"] as! TableStringFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "statusDate")
    }
  }

  public var order: TableIntFilterInput? {
    get {
      return graphQLMap["order"] as! TableIntFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "order")
    }
  }
}

public struct TableIDFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: GraphQLID? = nil, eq: GraphQLID? = nil, le: GraphQLID? = nil, lt: GraphQLID? = nil, ge: GraphQLID? = nil, gt: GraphQLID? = nil, contains: GraphQLID? = nil, notContains: GraphQLID? = nil, between: [GraphQLID?]? = nil, beginsWith: GraphQLID? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith]
  }

  public var ne: GraphQLID? {
    get {
      return graphQLMap["ne"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: GraphQLID? {
    get {
      return graphQLMap["eq"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: GraphQLID? {
    get {
      return graphQLMap["le"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: GraphQLID? {
    get {
      return graphQLMap["lt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: GraphQLID? {
    get {
      return graphQLMap["ge"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: GraphQLID? {
    get {
      return graphQLMap["gt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: GraphQLID? {
    get {
      return graphQLMap["contains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: GraphQLID? {
    get {
      return graphQLMap["notContains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [GraphQLID?]? {
    get {
      return graphQLMap["between"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: GraphQLID? {
    get {
      return graphQLMap["beginsWith"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }
}

public struct TableStringFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: String? = nil, eq: String? = nil, le: String? = nil, lt: String? = nil, ge: String? = nil, gt: String? = nil, contains: String? = nil, notContains: String? = nil, between: [String?]? = nil, beginsWith: String? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith]
  }

  public var ne: String? {
    get {
      return graphQLMap["ne"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: String? {
    get {
      return graphQLMap["eq"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: String? {
    get {
      return graphQLMap["le"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: String? {
    get {
      return graphQLMap["lt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: String? {
    get {
      return graphQLMap["ge"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: String? {
    get {
      return graphQLMap["gt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: String? {
    get {
      return graphQLMap["contains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: String? {
    get {
      return graphQLMap["notContains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [String?]? {
    get {
      return graphQLMap["between"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: String? {
    get {
      return graphQLMap["beginsWith"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }
}

public struct TableIntFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: Int? = nil, eq: Int? = nil, le: Int? = nil, lt: Int? = nil, ge: Int? = nil, gt: Int? = nil, contains: Int? = nil, notContains: Int? = nil, between: [Int?]? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between]
  }

  public var ne: Int? {
    get {
      return graphQLMap["ne"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: Int? {
    get {
      return graphQLMap["eq"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: Int? {
    get {
      return graphQLMap["le"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: Int? {
    get {
      return graphQLMap["lt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: Int? {
    get {
      return graphQLMap["ge"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: Int? {
    get {
      return graphQLMap["gt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: Int? {
    get {
      return graphQLMap["contains"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: Int? {
    get {
      return graphQLMap["notContains"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [Int?]? {
    get {
      return graphQLMap["between"] as! [Int?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }
}

public final class CreateTaskMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateTask($input: CreateTaskInput!) {\n  createTask(input: $input) {\n    __typename\n    id\n    title\n    status\n    statusDate\n    order\n  }\n}"

  public var input: CreateTaskInput

  public init(input: CreateTaskInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createTask", arguments: ["input": GraphQLVariable("input")], type: .object(CreateTask.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createTask: CreateTask? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "createTask": createTask.flatMap { $0.snapshot }])
    }

    public var createTask: CreateTask? {
      get {
        return (snapshot["createTask"] as? Snapshot).flatMap { CreateTask(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "createTask")
      }
    }

    public struct CreateTask: GraphQLSelectionSet {
      public static let possibleTypes = ["Task"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(TaskStatus.self))),
        GraphQLField("statusDate", type: .scalar(String.self)),
        GraphQLField("order", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, status: TaskStatus, statusDate: String? = nil, order: Int) {
        self.init(snapshot: ["__typename": "Task", "id": id, "title": title, "status": status, "statusDate": statusDate, "order": order])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var status: TaskStatus {
        get {
          return snapshot["status"]! as! TaskStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      public var statusDate: String? {
        get {
          return snapshot["statusDate"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "statusDate")
        }
      }

      public var order: Int {
        get {
          return snapshot["order"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "order")
        }
      }
    }
  }
}

public final class UpdateTaskMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpdateTask($input: UpdateTaskInput!) {\n  updateTask(input: $input) {\n    __typename\n    id\n    title\n    status\n    statusDate\n    order\n  }\n}"

  public var input: UpdateTaskInput

  public init(input: UpdateTaskInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateTask", arguments: ["input": GraphQLVariable("input")], type: .object(UpdateTask.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(updateTask: UpdateTask? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "updateTask": updateTask.flatMap { $0.snapshot }])
    }

    public var updateTask: UpdateTask? {
      get {
        return (snapshot["updateTask"] as? Snapshot).flatMap { UpdateTask(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "updateTask")
      }
    }

    public struct UpdateTask: GraphQLSelectionSet {
      public static let possibleTypes = ["Task"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(TaskStatus.self))),
        GraphQLField("statusDate", type: .scalar(String.self)),
        GraphQLField("order", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, status: TaskStatus, statusDate: String? = nil, order: Int) {
        self.init(snapshot: ["__typename": "Task", "id": id, "title": title, "status": status, "statusDate": statusDate, "order": order])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var status: TaskStatus {
        get {
          return snapshot["status"]! as! TaskStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      public var statusDate: String? {
        get {
          return snapshot["statusDate"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "statusDate")
        }
      }

      public var order: Int {
        get {
          return snapshot["order"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "order")
        }
      }
    }
  }
}

public final class DeleteTaskMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeleteTask($input: DeleteTaskInput!) {\n  deleteTask(input: $input) {\n    __typename\n    id\n    title\n    status\n    statusDate\n    order\n  }\n}"

  public var input: DeleteTaskInput

  public init(input: DeleteTaskInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteTask", arguments: ["input": GraphQLVariable("input")], type: .object(DeleteTask.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(deleteTask: DeleteTask? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deleteTask": deleteTask.flatMap { $0.snapshot }])
    }

    public var deleteTask: DeleteTask? {
      get {
        return (snapshot["deleteTask"] as? Snapshot).flatMap { DeleteTask(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deleteTask")
      }
    }

    public struct DeleteTask: GraphQLSelectionSet {
      public static let possibleTypes = ["Task"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(TaskStatus.self))),
        GraphQLField("statusDate", type: .scalar(String.self)),
        GraphQLField("order", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, status: TaskStatus, statusDate: String? = nil, order: Int) {
        self.init(snapshot: ["__typename": "Task", "id": id, "title": title, "status": status, "statusDate": statusDate, "order": order])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var status: TaskStatus {
        get {
          return snapshot["status"]! as! TaskStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      public var statusDate: String? {
        get {
          return snapshot["statusDate"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "statusDate")
        }
      }

      public var order: Int {
        get {
          return snapshot["order"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "order")
        }
      }
    }
  }
}

public final class GetTaskQuery: GraphQLQuery {
  public static let operationString =
    "query GetTask($id: ID!, $order: Int!) {\n  getTask(id: $id, order: $order) {\n    __typename\n    id\n    title\n    status\n    statusDate\n    order\n  }\n}"

  public var id: GraphQLID
  public var order: Int

  public init(id: GraphQLID, order: Int) {
    self.id = id
    self.order = order
  }

  public var variables: GraphQLMap? {
    return ["id": id, "order": order]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getTask", arguments: ["id": GraphQLVariable("id"), "order": GraphQLVariable("order")], type: .object(GetTask.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getTask: GetTask? = nil) {
      self.init(snapshot: ["__typename": "Query", "getTask": getTask.flatMap { $0.snapshot }])
    }

    public var getTask: GetTask? {
      get {
        return (snapshot["getTask"] as? Snapshot).flatMap { GetTask(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getTask")
      }
    }

    public struct GetTask: GraphQLSelectionSet {
      public static let possibleTypes = ["Task"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(TaskStatus.self))),
        GraphQLField("statusDate", type: .scalar(String.self)),
        GraphQLField("order", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, status: TaskStatus, statusDate: String? = nil, order: Int) {
        self.init(snapshot: ["__typename": "Task", "id": id, "title": title, "status": status, "statusDate": statusDate, "order": order])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var status: TaskStatus {
        get {
          return snapshot["status"]! as! TaskStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      public var statusDate: String? {
        get {
          return snapshot["statusDate"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "statusDate")
        }
      }

      public var order: Int {
        get {
          return snapshot["order"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "order")
        }
      }
    }
  }
}

public final class ListTasksQuery: GraphQLQuery {
  public static let operationString =
    "query ListTasks($filter: TableTaskFilterInput, $limit: Int, $nextToken: String) {\n  listTasks(filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      title\n      status\n      statusDate\n      order\n    }\n    nextToken\n  }\n}"

  public var filter: TableTaskFilterInput?
  public var limit: Int?
  public var nextToken: String?

  public init(filter: TableTaskFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
  }

  public var variables: GraphQLMap? {
    return ["filter": filter, "limit": limit, "nextToken": nextToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("listTasks", arguments: ["filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(ListTask.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(listTasks: ListTask? = nil) {
      self.init(snapshot: ["__typename": "Query", "listTasks": listTasks.flatMap { $0.snapshot }])
    }

    public var listTasks: ListTask? {
      get {
        return (snapshot["listTasks"] as? Snapshot).flatMap { ListTask(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "listTasks")
      }
    }

    public struct ListTask: GraphQLSelectionSet {
      public static let possibleTypes = ["TaskConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .list(.object(Item.selections))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?]? = nil, nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "TaskConnection", "items": items.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?]? {
        get {
          return (snapshot["items"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Item(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Task"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("status", type: .nonNull(.scalar(TaskStatus.self))),
          GraphQLField("statusDate", type: .scalar(String.self)),
          GraphQLField("order", type: .nonNull(.scalar(Int.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, title: String, status: TaskStatus, statusDate: String? = nil, order: Int) {
          self.init(snapshot: ["__typename": "Task", "id": id, "title": title, "status": status, "statusDate": statusDate, "order": order])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String {
          get {
            return snapshot["title"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "title")
          }
        }

        public var status: TaskStatus {
          get {
            return snapshot["status"]! as! TaskStatus
          }
          set {
            snapshot.updateValue(newValue, forKey: "status")
          }
        }

        public var statusDate: String? {
          get {
            return snapshot["statusDate"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "statusDate")
          }
        }

        public var order: Int {
          get {
            return snapshot["order"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "order")
          }
        }
      }
    }
  }
}

public final class OnCreateTaskSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnCreateTask($id: ID, $title: String, $status: TaskStatus, $statusDate: AWSDateTime, $order: Int) {\n  onCreateTask(id: $id, title: $title, status: $status, statusDate: $statusDate, order: $order) {\n    __typename\n    id\n    title\n    status\n    statusDate\n    order\n  }\n}"

  public var id: GraphQLID?
  public var title: String?
  public var status: TaskStatus?
  public var statusDate: String?
  public var order: Int?

  public init(id: GraphQLID? = nil, title: String? = nil, status: TaskStatus? = nil, statusDate: String? = nil, order: Int? = nil) {
    self.id = id
    self.title = title
    self.status = status
    self.statusDate = statusDate
    self.order = order
  }

  public var variables: GraphQLMap? {
    return ["id": id, "title": title, "status": status, "statusDate": statusDate, "order": order]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onCreateTask", arguments: ["id": GraphQLVariable("id"), "title": GraphQLVariable("title"), "status": GraphQLVariable("status"), "statusDate": GraphQLVariable("statusDate"), "order": GraphQLVariable("order")], type: .object(OnCreateTask.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onCreateTask: OnCreateTask? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onCreateTask": onCreateTask.flatMap { $0.snapshot }])
    }

    public var onCreateTask: OnCreateTask? {
      get {
        return (snapshot["onCreateTask"] as? Snapshot).flatMap { OnCreateTask(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onCreateTask")
      }
    }

    public struct OnCreateTask: GraphQLSelectionSet {
      public static let possibleTypes = ["Task"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(TaskStatus.self))),
        GraphQLField("statusDate", type: .scalar(String.self)),
        GraphQLField("order", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, status: TaskStatus, statusDate: String? = nil, order: Int) {
        self.init(snapshot: ["__typename": "Task", "id": id, "title": title, "status": status, "statusDate": statusDate, "order": order])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var status: TaskStatus {
        get {
          return snapshot["status"]! as! TaskStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      public var statusDate: String? {
        get {
          return snapshot["statusDate"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "statusDate")
        }
      }

      public var order: Int {
        get {
          return snapshot["order"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "order")
        }
      }
    }
  }
}

public final class OnUpdateTaskSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnUpdateTask($id: ID, $title: String, $status: TaskStatus, $statusDate: AWSDateTime, $order: Int) {\n  onUpdateTask(id: $id, title: $title, status: $status, statusDate: $statusDate, order: $order) {\n    __typename\n    id\n    title\n    status\n    statusDate\n    order\n  }\n}"

  public var id: GraphQLID?
  public var title: String?
  public var status: TaskStatus?
  public var statusDate: String?
  public var order: Int?

  public init(id: GraphQLID? = nil, title: String? = nil, status: TaskStatus? = nil, statusDate: String? = nil, order: Int? = nil) {
    self.id = id
    self.title = title
    self.status = status
    self.statusDate = statusDate
    self.order = order
  }

  public var variables: GraphQLMap? {
    return ["id": id, "title": title, "status": status, "statusDate": statusDate, "order": order]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onUpdateTask", arguments: ["id": GraphQLVariable("id"), "title": GraphQLVariable("title"), "status": GraphQLVariable("status"), "statusDate": GraphQLVariable("statusDate"), "order": GraphQLVariable("order")], type: .object(OnUpdateTask.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onUpdateTask: OnUpdateTask? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onUpdateTask": onUpdateTask.flatMap { $0.snapshot }])
    }

    public var onUpdateTask: OnUpdateTask? {
      get {
        return (snapshot["onUpdateTask"] as? Snapshot).flatMap { OnUpdateTask(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdateTask")
      }
    }

    public struct OnUpdateTask: GraphQLSelectionSet {
      public static let possibleTypes = ["Task"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(TaskStatus.self))),
        GraphQLField("statusDate", type: .scalar(String.self)),
        GraphQLField("order", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, status: TaskStatus, statusDate: String? = nil, order: Int) {
        self.init(snapshot: ["__typename": "Task", "id": id, "title": title, "status": status, "statusDate": statusDate, "order": order])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var status: TaskStatus {
        get {
          return snapshot["status"]! as! TaskStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      public var statusDate: String? {
        get {
          return snapshot["statusDate"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "statusDate")
        }
      }

      public var order: Int {
        get {
          return snapshot["order"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "order")
        }
      }
    }
  }
}

public final class OnDeleteTaskSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnDeleteTask($id: ID, $title: String, $status: TaskStatus, $statusDate: AWSDateTime, $order: Int) {\n  onDeleteTask(id: $id, title: $title, status: $status, statusDate: $statusDate, order: $order) {\n    __typename\n    id\n    title\n    status\n    statusDate\n    order\n  }\n}"

  public var id: GraphQLID?
  public var title: String?
  public var status: TaskStatus?
  public var statusDate: String?
  public var order: Int?

  public init(id: GraphQLID? = nil, title: String? = nil, status: TaskStatus? = nil, statusDate: String? = nil, order: Int? = nil) {
    self.id = id
    self.title = title
    self.status = status
    self.statusDate = statusDate
    self.order = order
  }

  public var variables: GraphQLMap? {
    return ["id": id, "title": title, "status": status, "statusDate": statusDate, "order": order]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onDeleteTask", arguments: ["id": GraphQLVariable("id"), "title": GraphQLVariable("title"), "status": GraphQLVariable("status"), "statusDate": GraphQLVariable("statusDate"), "order": GraphQLVariable("order")], type: .object(OnDeleteTask.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onDeleteTask: OnDeleteTask? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onDeleteTask": onDeleteTask.flatMap { $0.snapshot }])
    }

    public var onDeleteTask: OnDeleteTask? {
      get {
        return (snapshot["onDeleteTask"] as? Snapshot).flatMap { OnDeleteTask(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onDeleteTask")
      }
    }

    public struct OnDeleteTask: GraphQLSelectionSet {
      public static let possibleTypes = ["Task"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(TaskStatus.self))),
        GraphQLField("statusDate", type: .scalar(String.self)),
        GraphQLField("order", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, title: String, status: TaskStatus, statusDate: String? = nil, order: Int) {
        self.init(snapshot: ["__typename": "Task", "id": id, "title": title, "status": status, "statusDate": statusDate, "order": order])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return snapshot["title"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "title")
        }
      }

      public var status: TaskStatus {
        get {
          return snapshot["status"]! as! TaskStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      public var statusDate: String? {
        get {
          return snapshot["statusDate"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "statusDate")
        }
      }

      public var order: Int {
        get {
          return snapshot["order"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "order")
        }
      }
    }
  }
}