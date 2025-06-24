// Demonstrate Vala features: class, property, signal, but only print 'Hello World!'
class Greeter : Object {
    public string message { get; set; }
    public signal void greeted (string who);
    public Greeter (string msg) {
        this.message = msg;
    }
    public void greet () {
        // Only print the required output
        print ("%s\n", message);
        greeted ("World"); // Signal emitted, but handler does nothing
    }
}

void main () {
    var greeter = new Greeter ("Hello World!");
    greeter.greeted.connect ((who) => {
        // Signal handler intentionally left blank to avoid extra output
    });
    greeter.greet();
}

// Uncomment to run the feature-rich version
// main_with_features();