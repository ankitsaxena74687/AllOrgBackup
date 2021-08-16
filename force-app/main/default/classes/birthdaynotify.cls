global class birthdaynotify Implements Database.Batchable <sObject>{
    
global Database.queryLocator start(Database.BatchableContext bc)
{
DateTime dt = system.now();
String Query = 'SELECT Id, Name, Email FROM Contact WHERE DAY_IN_MONTH(DOB__c) = ' + dt.day() + ' AND CALENDAR_MONTH(DOB__c) = ' + dt.month();
return Database.getQueryLocator(Query);
}
    
global void execute(Database.BatchableContext bc, List<Contact> conlist)
{
List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
for(contact c : conlist)
{
List<String> em = new List<String>{c.Email};
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(em);
mail.setSubject('Happy Birthday');
String messageBody = '<html><body>Hi ' + c.Name + ',<br/>Happy Birthday my dear.<br/>wish u very very Happy '+'Returns of the day.<br/><br/><b>Regards,</b><br/>Ankit kumar verma</body></html>';
mail.setHtmlBody(messageBody);
mailList.add(mail);
}
Messaging.sendEmail(mailList);
}
global void finish(Database.BatchableContext bc)
{
}
}