public class QuickContactCheckClass{
  @AuraEnabled
    public static String Mymethod(String AcId){
        Account ac=[select id,Type from Account where Id =:AcId];
        return ac.Type;
    }
}