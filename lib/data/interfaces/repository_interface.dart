abstract class IRepository<T> {
  Future<List<T>> getAllAsync();

  Future<T?> getAsync(id);

  Future<bool> addAsync(id, T data);

  Future<bool> deleteAsync(id);

  Future<bool> editAsync(id, T data);
}
