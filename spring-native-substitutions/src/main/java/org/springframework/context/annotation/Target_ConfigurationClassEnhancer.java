package org.springframework.context.annotation;

import com.oracle.svm.core.annotate.Delete;
import com.oracle.svm.core.annotate.TargetClass;

import org.springframework.nativex.substitutions.OnlyIfPresent;

@Delete
@TargetClass(className = "org.springframework.context.annotation.ConfigurationClassEnhancer", onlyWith = { OnlyIfPresent.class })
final class Target_ConfigurationClassEnhancer {
}

