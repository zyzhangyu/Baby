import Combine

let _ = Just(5) ///Interger Never
    .map { value -> String in
        // do something with the incoming value here
        // and return a string
        return "a string"
    }
    .sink { receivedValue in
        // sink is the subscriber and terminates the pipeline
        print("The end result was \(receivedValue)")
    }



let _ = Just(5)
.map { value -> String in
    switch value {
    case _ where value < 1:
        return "none"
    case _ where value == 1:
        return "one"
    case _ where value == 2:
        return "couple"
    case _ where value == 3:
        return "few"
    case _ where value > 8:
        return "many"
    default:
        return "some"
    }
}
.sink { receivedValue in
    print("The end result was \(receivedValue)")
}
