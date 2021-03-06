/*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

package codetoanalyze.java.eradicate;

import com.google.common.base.Optional;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.util.stream.Stream;
import javax.annotation.Nonnull;
import javax.annotation.Nullable;

public class ReturnNotNullable {

  void returnvoid() {
    // No warning here.
  }

  Void returnVoid() {
    // This is OK too.
    return null;
  }

  String returnNull() {
    return null;
  }

  String returnNullable(@Nullable String s) {
    return s;
  }

  @Nonnull
  String returnNonnull() {
    return "abc";
  }

  @Nullable
  String returnNullOK() {
    return null;
  }

  @Nullable
  String returnNullableOK(@Nullable String s) {
    return s;
  }

  String throwException(@Nullable Exception e, boolean bad) throws Exception {
    if (bad) {
      throw (e); // no ERADICATE_RETURN_NOT_NULLABLE should be reported
    }
    return "OK";
  }

  @Nullable
  String redundantEq() {
    String s = returnNonnull();
    int n = s == null ? 0 : s.length();
    return s;
  }

  @Nullable
  String redundantNeq() {
    String s = returnNonnull();
    int n = s != null ? 0 : s.length();
    return s;
  }

  @Nonnull
  BufferedReader nn(BufferedReader br) {
    return br;
  }

  void tryWithResources(String path) {
    try (BufferedReader br = nn(new BufferedReader(new FileReader(path)))) {
    } // no condition redundant should be reported on this line
    catch (IOException e) {
    }
  }

  Object tryWithResourcesReturnNullable(String path) throws IOException {
    try (BufferedReader br = nn(new BufferedReader(new FileReader(path)))) {
      return returnNullOK();
    }
  }

  /*
  Check that orNull is modelled and RETURN_OVER_ANNOTATED is not returned.
   */
  @Nullable
  String testOptional(Optional<String> os) {
    return os.orNull();
  }

  class E extends Exception {}

  String return_null_in_catch() {
    try {
      throw new E();
    } catch (E e) {
      return null;
    }
  }

  String return_null_in_catch_after_throw() {
    try {
      try {
        throw new E();
      } catch (E e) {
        throw e;
      }
    } catch (E e) {
      return null;
    }
  }

  URL getResourceNullable(Class cls, String name) {
    return cls.getResource(name);
  }

  @DefinitelyNotNullable
  Object definitelyDoesNotReturnNull() {
    return new Object();
  }

  void callsnotnullableMethod() {
    definitelyDoesNotReturnNull().toString();
  }

  static class ConditionalAssignment {
    @Nullable Object f1;

    static Object test(boolean b) {
      ConditionalAssignment x = new ConditionalAssignment();
      if (b) {
        x.f1 = new Object();
      }
      return x.f1; // can be null
    }
  }

  Stream<Object> methodUsesLambda(Stream<Object> stream) {
    return stream.map(x -> null); // Intentionaly not reporting here
  }

  Object $generatedReturnsNullOk() {
    return null;
  }

  int field;

  int returnsZero() {
    field = 0;
    return field;
  }
}
