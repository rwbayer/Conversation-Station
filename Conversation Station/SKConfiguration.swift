//
//  SKConfiguration.swift
//  Conversation Station
//
//  Created by Bobby Bayer on 1/26/17.
//  Copyright © 2017 Robert Bayer. All rights reserved.
//

import Foundation

var SKAppKey = "c08cc45f6416db4bc44b79b03fbbfe34238e412edc80489789c16ec047e78c07735066d86641232a8d9cdbcc57d9007b6742a943c2f1db4bb2490cf9309800a4"
var SKAppId = "NMDPTRIAL_rbayer_scu_edu20170123204829"
var SKServerHost = "sslsandbox-nmdp.nuancemobility.net"
var SKServerPort = "443"

var SKLanguage = "!LANGUAGE!"

var SKServerUrl = String(format: "nmsps://%@@%@:%@", SKAppId, SKServerHost, SKServerPort)

// Only needed if using NLU/Bolt
var SKNLUContextTag = "!NLU_CONTEXT_TAG!"


let LANGUAGE = SKLanguage == "!LANGUAGE!" ? "eng-USA" : SKLanguage
