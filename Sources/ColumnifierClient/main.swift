import Columnifier
import Foundation
import GRDB

struct Checklist {
  let name: String
  let id: UUID
}

let column = #Columnify(\Checklist.id)

print("The column is \(column)")
