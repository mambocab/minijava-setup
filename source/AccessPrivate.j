class HasPrivateMember {
    private int foo;
    public HasPrivateMember() {
        foo = 19;
    }
}

class Main {
    static void main() {
        HasPrivateMember pm = new HasPrivateMember();
        int x = pm.foo;
        return;
    }
}
