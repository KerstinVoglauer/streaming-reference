import com.github.geoheil.streamingreference.Libraries

//plugins {
//    application
//}
// https://github.com/johnrengelman/shadow/issues/336

description = "Streaming Wordcount"

dependencies {
    compileOnly(Libraries.flinkJava)
    compileOnly(Libraries.flinkRuntime)
    compileOnly(Libraries.flinkRuntimeWeb)
    compileOnly(Libraries.flinkStreamingScala)
}

//val mainClass = "com.github.geoheil.streamingreference.streamingwc.StreamingWordCount"

//application {
//    mainClass.set(mainClass)
//}
//
//val shadowJar: com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar by tasks
//shadowJar.apply {
//    manifest.attributes.apply {
//        put("Main-Class", mainClass)
//    }
//}