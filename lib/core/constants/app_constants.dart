// pubspec.yaml dependencies

class AppConstants {
  static const String appName = 'Chello Bakery Management';
  static const String version = '1.0.0';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String rawMaterialsCollection = 'rawMaterials';
  static const String rawMaterialTransactionsCollection = 'rawMaterialTransactions';
  static const String suppliersCollection = 'suppliers';
  static const String ordersCollection = 'orders';
  static const String orderItemsCollection = 'orderItems';
  static const String clientsCollection = 'clients';
  static const String productsCollection = 'products';
  static const String billsOfMaterialsCollection = 'billsOfMaterials';
  static const String productionPlansCollection = 'productionPlans';
  static const String productionLogsCollection = 'productionLogs';
  static const String dispatchesCollection = 'dispatches';
  static const String dispatchItemsCollection = 'dispatchItems';
  static const String dailyReportsCollection = 'dailyReports';
  static const String auditLogsCollection = 'auditLogs';
  
  // User Roles
  static const String roleManager = 'manager';
  static const String roleProductionSupervisor = 'production_supervisor';
  static const String roleStorekeeper = 'storekeeper';
  static const String roleDispatchOfficer = 'dispatch_officer';
  static const String roleSalesAdminClerk = 'sales_admin_clerk';
  
  // Order Status
  static const String orderStatusRequested = 'requested';
  static const String orderStatusApproved = 'approved';
  static const String orderStatusFulfilled = 'fulfilled';
  static const String orderStatusRejected = 'rejected';
  
  // Dispatch Status
  static const String dispatchStatusPending = 'pending';
  static const String dispatchStatusDispatched = 'dispatched';
  static const String dispatchStatusDelivered = 'delivered';
  
  // Production Status
  static const String productionStatusPlanned = 'planned';
  static const String productionStatusInProgress = 'in_progress';
  static const String productionStatusCompleted = 'completed';
}
