/*
 * Copyright (c) 2014, Oracle America, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *  * Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 *  * Neither the name of Oracle nor the names of its contributors may be used
 *    to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */
package com.wordalytica.wordset;

import com.wordalytica.wordset.core.WordSet;
import org.openjdk.jmh.annotations.Benchmark;
import org.openjdk.jmh.annotations.BenchmarkMode;
import org.openjdk.jmh.annotations.Fork;
import org.openjdk.jmh.annotations.Measurement;
import org.openjdk.jmh.annotations.Mode;
import org.openjdk.jmh.annotations.OutputTimeUnit;
import org.openjdk.jmh.annotations.Scope;
import org.openjdk.jmh.annotations.Setup;
import org.openjdk.jmh.annotations.State;
import org.openjdk.jmh.annotations.Warmup;
import org.openjdk.jmh.runner.Runner;
import org.openjdk.jmh.runner.RunnerException;
import org.openjdk.jmh.runner.options.Options;
import org.openjdk.jmh.runner.options.OptionsBuilder;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;

// TODO: Move this to it's own benchmarking module.
public class Benchmarker {
    @BenchmarkMode(Mode.AverageTime)
    @Fork(1)
    @State(Scope.Thread)
    @OutputTimeUnit(TimeUnit.MILLISECONDS)
    public static abstract class WordsetBenchmark {
        ConcurrentHashMap<Class<? extends WordsetBenchmark>, WordSet<?>> classNameToWordSet = new ConcurrentHashMap<>();

        @Setup
        public void setup() {
            classNameToWordSet.put(this.getClass(), buildWordSet());
        }

        @Benchmark
        @Warmup(iterations = 10, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        @Measurement(iterations = 10, time = 100, timeUnit = TimeUnit.MILLISECONDS)
        public void performOperations() {
            WordSet<?> wordset = classNameToWordSet.get(this.getClass());
            wordset.endingWith("ing").count();
            wordset.startingWith("foo").containing("bar").count();
            wordset.matching("benc_mark").count();
            wordset.startingWith("fish").notEndingWith("ing").count();
        }

        protected abstract WordSet<?> buildWordSet();
    }

    public static class BenchmarkV0 extends WordsetBenchmark {
        @Override
        protected WordSet<?> buildWordSet() {
            return WordSetFactory.buildNoop();
        }
    }

    public static class BenchmarkV1 extends WordsetBenchmark {
        @Override
        protected WordSet<?> buildWordSet() {
            return WordSetFactory.build(this, "words.all", 1);
        }
    }

    public static class BenchmarkV2 extends WordsetBenchmark {
        @Override
        protected WordSet<?> buildWordSet() {
            return WordSetFactory.build(this, "words.all", 2);
        }
    }
    /*
     * ============================== HOW TO RUN THIS TEST: ====================================
     *
     * You can run this test, and compare different wordset performances
     *
     * How to run this outside of the IDE is described here:
     * http://openjdk.java.net/projects/code-tools/jmh/
     */
    public static void main(String[] args) throws RunnerException {
        Options opt = new OptionsBuilder()
                .include(Benchmarker.class.getSimpleName())
                //.addProfiler("org.openjdk.jmh.profile.HotspotMemoryProfiler")
                .build();

        new Runner(opt).run();
    }
}
