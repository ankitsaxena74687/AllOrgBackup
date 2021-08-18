public class Checkrecursion {
    public static boolean hasAlreadyRun = false;
    public static boolean hasAlreadyRunMethod(){
        return hasAlreadyRun;
    }
    public static void setAlreadyRunMethod(){
        hasAlreadyRun = true;}}