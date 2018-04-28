--!A cross-platform build utility based on Lua
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- 
-- Copyright (C) 2015 - 2018, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        xmake.lua
--

-- define rule: environment
rule("wdk.env")

    -- on load
    on_load(function (target)
        import("detect.sdks.find_wdk")
        if not target:data("wdk") then
            target:data_set("wdk", assert(find_wdk(nil, {verbose = true}), "WDK not found!"))
        end
    end)

    -- clean files
    after_clean(function (target)
        for _, file in ipairs(target:data("wdk.cleanfiles")) do
            os.rm(file)
        end
        target:data_set("wdk.cleanfiles", nil)
    end)

-- define rule: umdf driver
rule("wdk.driver.umdf")

    -- add rules
    add_deps("wdk.env")

-- define rule: kmdf driver
rule("wdk.driver.kmdf")

    -- add rules
    add_deps("wdk.env")

-- define rule: binary
rule("wdk.binary")

    -- add rules
    add_deps("wdk.env")

