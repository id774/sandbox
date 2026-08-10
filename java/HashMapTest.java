import java.util.HashMap;

public class HashMapTest {
    public static void main(String [] args) {
        HashMap<String,String> map = new HashMap<String,String>();
        map.put("apple", "apple   ");
        map.put("grapes", "   grapes");
        System.out.println(map.get("apple"));
        System.out.println(map.get("grapes"));
    }
}
