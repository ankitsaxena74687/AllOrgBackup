public class SearchAccountReview {
  @AuraEnabled
    public static List<MyReviews__c> getAll(Id AccountId){
    return [select id,	Your_Reviews__c,Name from MyReviews__c where Account__c=:AccountId];
    }
}