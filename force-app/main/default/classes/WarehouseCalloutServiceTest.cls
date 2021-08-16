@isTest
private class WarehouseCalloutServiceTest {
    @isTest
    static void testWarehouseCalloutService(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();
    }
}