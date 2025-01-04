 enum UserType
{
  admin,
  client
  
}
enum ItemStatus{
  available,
  notAvailable,
  willBeAvailable
}
enum DeliveryType{
  inPlace,
  shipped,
}
enum OrderStatus{
  initial,
  inProgress,
  delivered,
  cancelled
}
enum GlobalStatus{
  initial,
  initialLoaded,
  loading,
  loaded,
    error
}
enum AuthStatus{
  initial,
  initialLoaded,
  loading,
  loaded,
    error
}