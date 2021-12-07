abstract class IRepository<T> {
  Future<List<T>> getAllAsync();

  Future<T?> getAsync(String id);

  Future<bool> addAsync(T data);

  Future<bool> deleteAsync(String id);

  Future<bool> editAsync(String id, T data);
}
