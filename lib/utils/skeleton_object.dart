mixin SkeletonObject<T> {
  T populate();

  Type get populatedType => T;
}
