# Copyright (c) 2015 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# IIO sensors HAL module implementation, compiled as hw/iio-sensors-hal.so

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

src_path := .
src_files := $(src_path)/entry.c \
	     $(src_path)/enumeration.c \
	     $(src_path)/control.c \
	     $(src_path)/description.c \
	     $(src_path)/utils.c \
	     $(src_path)/transform.c \
	     $(src_path)/compass-calibration.c \
	     $(src_path)/matrix-ops.c \
	     $(src_path)/gyro-calibration.c \
	     $(src_path)/filtering.c \
	     $(src_path)/discovery.c \
	     $(src_path)/accel-calibration.c \

ifeq ($(HAL_AUTODETECT),true)
LOCAL_MODULE := iio-sensors-hal
else
LOCAL_MODULE := sensors.iio
endif
LOCAL_MODULE_OWNER := intel
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -DLOG_TAG=\"Sensors\" -fvisibility=hidden -Wno-missing-field-initializers
ifeq ($(NO_IIO_EVENTS),true)
LOCAL_CFLAGS += -D__NO_EVENTS__
endif
LOCAL_LDFLAGS := -Wl,--gc-sections
LOCAL_HEADER_LIBRARIES := libhardware_headers libcutils_headers liblog_headers libutils_headers
LOCAL_SHARED_LIBRARIES := liblog libcutils libdl
LOCAL_PRELINK_MODULE := false
LOCAL_SRC_FILES := $(src_files)
LOCAL_PROPRIETARY_MODULE := true
LOCAL_VINTF_FRAGMENTS := iio.sensors@1.0.xml
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := sens
LOCAL_CFLAGS := -DLOG_TAG=\"Sensors\" -fvisibility=hidden
LOCAL_SHARED_LIBRARIES := liblog libcutils libdl
LOCAL_SRC_FILES := sens.c
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR_EXECUTABLES)
include $(BUILD_EXECUTABLE)


# Activity HAL module implementation

include $(CLEAR_VARS)

src_path := .
activity_src_files := $(src_path)/activity_event_entry.c \
		      $(src_path)/discovery.c \
	              $(src_path)/utils.c \

LOCAL_MODULE := activity_recognition.iio
LOCAL_MODULE_OWNER := intel
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -DLOG_TAG=\"Activity\" -fvisibility=hidden
LOCAL_LDFLAGS := -Wl,--gc-sections
LOCAL_SHARED_LIBRARIES := liblog libcutils
LOCAL_PRELINK_MODULE := false
LOCAL_SRC_FILES := $(activity_src_files)
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := activity
LOCAL_CFLAGS := -DLOG_TAG=\"Activity\" -fvisibility=hidden
LOCAL_SHARED_LIBRARIES := liblog libcutils libdl
LOCAL_SRC_FILES := activity.c
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR_EXECUTABLES)
include $(BUILD_EXECUTABLE)
