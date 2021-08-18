public class AccountHandler {
  public static void insertAccount(Integer n) {
    Integer counter = 1;
    
    List<Account> addAccounts = new List<Account>();
      while(counter<=n){
            Account store = new Account();
            store.Name = 'Acme Inc' + counter;
            store.AccountNumber = 'A000' + counter;
            addAccounts.add(store);
          counter=counter+1;
      }
      insert addAccounts;
  }}