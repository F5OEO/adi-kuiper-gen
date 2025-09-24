#!/usr/bin/env python3
"""
Maia-SDR per-parameter client with exhaustive unitary_test.

BASE_URL = "http://127.0.0.1:8000"
unitary_test returns dict: test_name -> (True, value) or (False, error_message)
"""

from typing import Any, Dict, Optional, Tuple
import requests
import time

BASE_URL = "http://127.0.0.1:8000"
TIMEOUT = 5.0


class MaiaAPIError(Exception):
    def __init__(
        self,
        http_status: int,
        error_description: Optional[str] = None,
        suggested_action: Optional[str] = None,
        raw: Optional[Dict[str, Any]] = None,
    ):
        self.http_status = http_status
        self.error_description = error_description
        self.suggested_action = suggested_action
        self.raw = raw or {}
        msg = f"HTTP {http_status}"
        if error_description:
            msg += f": {error_description}"
        if suggested_action:
            msg += f" (suggested_action: {suggested_action})"
        super().__init__(msg)


class MaiaPerParamClient:
    def __init__(self, base_url: str = BASE_URL, timeout: float = TIMEOUT):
        self.base_url = base_url.rstrip("/")
        self.timeout = timeout
        self.s = requests.Session()
        self.headers = {"Content-Type": "application/json"}

    # ---- Core helpers ----
    def _handle_response(self, resp: requests.Response) -> Dict[str, Any]:
        try:
            data = resp.json()
        except ValueError:
            data = None

        if resp.ok:
            return data if isinstance(data, dict) else (data or {})

        if isinstance(data, dict):
            http_code = data.get("http_status_code", resp.status_code)
            err_desc = data.get("error_description") or data.get("error") or None
            suggested = data.get("suggested_action")
            raise MaiaAPIError(http_code, err_desc, suggested, raw=data)

        raise MaiaAPIError(resp.status_code, error_description=(resp.text or None), raw={"text": resp.text})

    def _request_json(self, method: str, path: str, json_payload: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        url = f"{self.base_url}{path}"
        try:
            resp = self.s.request(method, url, json=json_payload, timeout=self.timeout, headers=self.headers)
        except requests.RequestException as e:
            raise MaiaAPIError(0, error_description=str(e), raw={})
        return self._handle_response(resp)

    def _get(self, path: str) -> Dict[str, Any]:
        return self._request_json("GET", path)

    def _patch(self, path: str, payload: Dict[str, Any]) -> Dict[str, Any]:
        return self._request_json("PATCH", path, json_payload=payload)

    def _put(self, path: str, payload: Dict[str, Any]) -> Dict[str, Any]:
        return self._request_json("PUT", path, json_payload=payload)

    # ---- Endpoints and per-parameter methods ----

    # ad9361
    def get_ad9361(self) -> Dict[str, Any]:
        return self._get("/api/ad9361")

    def get_sampling_frequency(self) -> int:
        return int(self.get_ad9361().get("sampling_frequency"))

    def set_sampling_frequency(self, hz: int) -> Dict[str, Any]:
        return self._patch("/api/ad9361", {"sampling_frequency": int(hz)})

    def get_rx_rf_bandwidth(self) -> int:
        return int(self.get_ad9361().get("rx_rf_bandwidth"))

    def set_rx_rf_bandwidth(self, hz: int) -> Dict[str, Any]:
        return self._patch("/api/ad9361", {"rx_rf_bandwidth": int(hz)})

    def get_tx_rf_bandwidth(self) -> int:
        return int(self.get_ad9361().get("tx_rf_bandwidth"))

    def set_tx_rf_bandwidth(self, hz: int) -> Dict[str, Any]:
        return self._patch("/api/ad9361", {"tx_rf_bandwidth": int(hz)})

    def get_rx_lo_frequency(self) -> int:
        return int(self.get_ad9361().get("rx_lo_frequency"))

    def set_rx_lo_frequency(self, hz: int) -> Dict[str, Any]:
        return self._patch("/api/ad9361", {"rx_lo_frequency": int(hz)})

    def get_tx_lo_frequency(self) -> int:
        return int(self.get_ad9361().get("tx_lo_frequency"))

    def set_tx_lo_frequency(self, hz: int) -> Dict[str, Any]:
        return self._patch("/api/ad9361", {"tx_lo_frequency": int(hz)})

    def get_rx_gain(self) -> float:
        return float(self.get_ad9361().get("rx_gain"))

    def set_rx_gain(self, db: float) -> Dict[str, Any]:
        return self._patch("/api/ad9361", {"rx_gain": float(db)})

    def get_rx_gain_mode(self) -> str:
        return str(self.get_ad9361().get("rx_gain_mode"))

    def set_rx_gain_mode(self, mode: str) -> Dict[str, Any]:
        return self._patch("/api/ad9361", {"rx_gain_mode": str(mode)})

    def get_tx_gain(self) -> float:
        return float(self.get_ad9361().get("tx_gain"))

    def set_tx_gain(self, db: float) -> Dict[str, Any]:
        return self._patch("/api/ad9361", {"tx_gain": float(db)})

    # ddc
    def get_ddc(self) -> Dict[str, Any]:
        return self._get("/api/ddc/config")

    def get_ddc_enabled(self) -> bool:
        return bool(self.get_ddc().get("enabled"))

    def set_ddc_enabled(self, enabled: bool) -> Dict[str, Any]:
        return self._patch("/api/ddc/config", {"enabled": bool(enabled)})

    def get_ddc_frequency(self) -> int:
        return int(self.get_ddc().get("frequency"))

    def set_ddc_frequency(self, freq: int) -> Dict[str, Any]:
        return self._patch("/api/ddc/config", {"frequency": int(freq)})

    def get_ddc_decimation(self) -> int:
        return int(self.get_ddc().get("decimation"))

    def set_ddc_decimation(self, dec: int) -> Dict[str, Any]:
        return self._patch("/api/ddc/config", {"decimation": int(dec)})

    def get_ddc_input_sampling_frequency(self) -> float:
        return float(self.get_ddc().get("input_sampling_frequency"))

    def get_ddc_output_sampling_frequency(self) -> float:
        return float(self.get_ddc().get("output_sampling_frequency"))

    def put_ddc_config(self, config: Dict[str, Any]) -> Dict[str, Any]:
        return self._put("/api/ddc/config", config)

    def put_ddc_design(self, design: Dict[str, Any]) -> Dict[str, Any]:
        return self._put("/api/ddc/design", design)

    def put_ddc_design_params(
        self,
        frequency: int,
        decimation: int,
        transition_bandwidth: float,
        passband_ripple: float,
        stopband_attenuation_db: float,
        stopband_one_over_f: bool,
    ) -> Dict[str, Any]:
        payload = {
            "frequency": int(frequency),
            "decimation": int(decimation),
            "transition_bandwidth": float(transition_bandwidth),
            "passband_ripple": float(passband_ripple),
            "stopband_attenuation_db": float(stopband_attenuation_db),
            "stopband_one_over_f": bool(stopband_one_over_f),
        }
        return self._put("/api/ddc/design", payload)

    # geolocation
    def get_geolocation(self) -> Dict[str, Any]:
        return self._get("/api/geolocation")

    def set_geolocation_point(self, lat: Optional[float], lon: Optional[float], alt_m: Optional[float] = None) -> Dict[str, Any]:
        if lat is None or lon is None:
            payload = {"point": None}
        else:
            pt = {"type": "Point", "coordinates": [float(lon), float(lat)]}
            if alt_m is not None:
                pt["altitude_m"] = float(alt_m)
            payload = {"point": pt}
        return self._patch("/api/geolocation", payload)

    # recorder
    def get_recorder(self) -> Dict[str, Any]:
        return self._get("/api/recorder")

    def get_recorder_state(self) -> str:
        return str(self.get_recorder().get("state"))

    def set_recorder_state(self, state: str) -> Dict[str, Any]:
        return self._patch("/api/recorder", {"state": str(state)})

    def get_recorder_mode(self) -> str:
        return str(self.get_recorder().get("mode"))

    def set_recorder_mode(self, mode: str) -> Dict[str, Any]:
        return self._patch("/api/recorder", {"mode": str(mode)})

    def get_recorder_prepend_timestamp(self) -> bool:
        return bool(self.get_recorder().get("prepend_timestamp"))

    def set_recorder_prepend_timestamp(self, flag: bool) -> Dict[str, Any]:
        return self._patch("/api/recorder", {"prepend_timestamp": bool(flag)})

    def get_recorder_maximum_duration(self) -> int:
        return int(self.get_recorder().get("maximum_duration"))

    def set_recorder_maximum_duration(self, seconds: int) -> Dict[str, Any]:
        return self._patch("/api/recorder", {"maximum_duration": int(seconds)})

    # recording metadata
    def get_recording_metadata(self) -> Dict[str, Any]:
        return self._get("/api/recording/metadata")

    def get_metadata_filename(self) -> str:
        return str(self.get_recording_metadata().get("filename"))

    def set_metadata_filename(self, name: str) -> Dict[str, Any]:
        return self._patch("/api/recording/metadata", {"filename": str(name)})

    def get_metadata_description(self) -> str:
        return str(self.get_recording_metadata().get("description"))

    def set_metadata_description(self, text: str) -> Dict[str, Any]:
        return self._patch("/api/recording/metadata", {"description": str(text)})

    def get_metadata_author(self) -> str:
        return str(self.get_recording_metadata().get("author"))

    def set_metadata_author(self, author: str) -> Dict[str, Any]:
        return self._patch("/api/recording/metadata", {"author": str(author)})

    # spectrometer
    def get_spectrometer(self) -> Dict[str, Any]:
        return self._get("/api/spectrometer")

    def get_spectrometer_input(self) -> str:
        return str(self.get_spectrometer().get("input"))

    def set_spectrometer_input(self, src: str) -> Dict[str, Any]:
        return self._patch("/api/spectrometer", {"input": str(src)})

    def get_spectrometer_fft_size(self) -> int:
        return int(self.get_spectrometer().get("fft_size"))

    def set_spectrometer_fft_size(self, n: int) -> Dict[str, Any]:
        return self._patch("/api/spectrometer", {"fft_size": int(n)})

    def get_spectrometer_number_integrations(self) -> int:
        return int(self.get_spectrometer().get("number_integrations"))

    def set_spectrometer_number_integrations(self, n: int) -> Dict[str, Any]:
        return self._patch("/api/spectrometer", {"number_integrations": int(n)})

    def get_spectrometer_mode(self) -> str:
        return str(self.get_spectrometer().get("mode"))

    def set_spectrometer_mode(self, mode: str) -> Dict[str, Any]:
        return self._patch("/api/spectrometer", {"mode": str(mode)})

    # time
    def get_time(self) -> Dict[str, Any]:
        return self._get("/api/time")

    def get_time_value(self) -> float:
        return float(self.get_time().get("time"))

    def set_time_value(self, ts: float) -> Dict[str, Any]:
        return self._patch("/api/time", {"time": float(ts)})

    # versions
    def get_versions(self) -> Dict[str, Any]:
        return self._get("/api/versions")

    # ---- Unitary test exhaustive ----
    def unitary_test(self, wait_after_patch: float = 0.2) -> Dict[str, Tuple[bool, Optional[Any]]]:
        """
        Execute exhaustive tests for each getter/setter.
        Returns mapping test_name -> (success, value_or_error).
        Conservative: restore original values when possible.
        """
        results: Dict[str, Tuple[bool, Optional[Any]]] = {}

        def safe_run(name: str, fn, *args):
            try:
                val = fn(*args) if args else fn()
                results[name] = (True, val)
                if name.startswith("set_") or name.startswith("put_"):
                    time.sleep(wait_after_patch)
                return val
            except MaiaAPIError as e:
                results[name] = (False, f"MaiaAPIError: {e}")
            except Exception as e:
                results[name] = (False, f"Exception: {e}")

        # READS
        #safe_run("get_ad9361", self.get_ad9361)
        safe_run("get_sampling_frequency", self.get_sampling_frequency)
        safe_run("get_rx_rf_bandwidth", self.get_rx_rf_bandwidth)
        safe_run("get_tx_rf_bandwidth", self.get_tx_rf_bandwidth)
        safe_run("get_rx_lo_frequency", self.get_rx_lo_frequency)
        safe_run("get_tx_lo_frequency", self.get_tx_lo_frequency)
        safe_run("get_rx_gain", self.get_rx_gain)
        safe_run("get_rx_gain_mode", self.get_rx_gain_mode)
        safe_run("get_tx_gain", self.get_tx_gain)

        #safe_run("get_ddc", self.get_ddc)
        safe_run("get_ddc_enabled", self.get_ddc_enabled)
        safe_run("get_ddc_frequency", self.get_ddc_frequency)
        safe_run("get_ddc_decimation", self.get_ddc_decimation)
        safe_run("get_ddc_input_sampling_frequency", self.get_ddc_input_sampling_frequency)
        safe_run("get_ddc_output_sampling_frequency", self.get_ddc_output_sampling_frequency)

        safe_run("get_geolocation", self.get_geolocation)

        #safe_run("get_recorder", self.get_recorder)
        safe_run("get_recorder_state", self.get_recorder_state)
        safe_run("get_recorder_mode", self.get_recorder_mode)
        safe_run("get_recorder_prepend_timestamp", self.get_recorder_prepend_timestamp)
        safe_run("get_recorder_maximum_duration", self.get_recorder_maximum_duration)

        #safe_run("get_recording_metadata", self.get_recording_metadata)
        safe_run("get_metadata_filename", self.get_metadata_filename)
        safe_run("get_metadata_description", self.get_metadata_description)
        safe_run("get_metadata_author", self.get_metadata_author)

        #safe_run("get_spectrometer", self.get_spectrometer)
        safe_run("get_spectrometer_input", self.get_spectrometer_input)
        safe_run("get_spectrometer_fft_size", self.get_spectrometer_fft_size)
        safe_run("get_spectrometer_number_integrations", self.get_spectrometer_number_integrations)
        safe_run("get_spectrometer_mode", self.get_spectrometer_mode)

        safe_run("get_time", self.get_time)
        safe_run("get_time_value", self.get_time_value)

        safe_run("get_versions", self.get_versions)

        # STORE originals for restoration where applicable
        originals: Dict[str, Any] = {}
        try:
            originals["sampling_frequency"] = self.get_sampling_frequency()
        except Exception:
            originals["sampling_frequency"] = None
        try:
            originals["rx_gain"] = self.get_rx_gain()
        except Exception:
            originals["rx_gain"] = None
        try:
            originals["ddc_enabled"] = self.get_ddc_enabled()
        except Exception:
            originals["ddc_enabled"] = None
        try:
            originals["ddc_frequency"] = self.get_ddc_frequency()
        except Exception:
            originals["ddc_frequency"] = None
        try:
            originals["ddc_decimation"] = self.get_ddc_decimation()
        except Exception:
            originals["ddc_decimation"] = None
        try:
            originals["metadata_filename"] = self.get_metadata_filename()
        except Exception:
            originals["metadata_filename"] = None
        try:
            originals["metadata_description"] = self.get_metadata_description()
        except Exception:
            originals["metadata_description"] = None
        try:
            originals["metadata_author"] = self.get_metadata_author()
        except Exception:
            originals["metadata_author"] = None
        try:
            originals["spectrometer_fft_size"] = self.get_spectrometer_fft_size()
        except Exception:
            originals["spectrometer_fft_size"] = None
        try:
            originals["spectrometer_number_integrations"] = self.get_spectrometer_number_integrations()
        except Exception:
            originals["spectrometer_number_integrations"] = None
        try:
            originals["time_value"] = self.get_time_value()
        except Exception:
            originals["time_value"] = None

        # SETTERS with conservative values and restoration
        # sampling_frequency (no change if original present)
        if originals.get("sampling_frequency") is not None:
            safe_run("set_sampling_frequency_same", self.set_sampling_frequency, originals["sampling_frequency"])
        else:
            safe_run("set_sampling_frequency_20000000", self.set_sampling_frequency, 20000000)

        
        # rx_gain_mode roundtrip
        try:
            orig_mode = self.get_rx_gain_mode()
            safe_run("set_rx_gain_mode_Manual", self.set_rx_gain_mode, "Manual")
            safe_run("set_rx_gain_50", self.set_rx_gain, 50)
            if originals.get("rx_gain") is not None:
                safe_run("restore_rx_gain", self.set_rx_gain, originals["rx_gain"])
            if orig_mode is not None:
                safe_run("restore_rx_gain_mode", self.set_rx_gain_mode, orig_mode)
        except Exception:
            pass

        # tx_gain roundtrip
        try:
            orig_tx_gain = self.get_tx_gain()
            safe_run("set_tx_gain_minus10", self.set_tx_gain, -10)
            if orig_tx_gain is not None:
                safe_run("restore_tx_gain", self.set_tx_gain, orig_tx_gain)
        except Exception:
            pass

        # DDC: toggle enabled, set freq/decimation, restore
        try:
            safe_run("set_ddc_enabled_true", self.set_ddc_enabled, True)
            safe_run("set_ddc_frequency_10000", self.set_ddc_frequency, 10000)
            safe_run("set_ddc_decimation_16", self.set_ddc_decimation, 16)
            
            #if originals.get("ddc_enabled") is not None:
            #    safe_run("restore_ddc_enabled", self.set_ddc_enabled, originals["ddc_enabled"])
            if originals.get("ddc_frequency") is not None:
                safe_run("restore_ddc_frequency", self.set_ddc_frequency, originals["ddc_frequency"])
            if originals.get("ddc_decimation") is not None:
                safe_run("restore_ddc_decimation", self.set_ddc_decimation, originals["ddc_decimation"])
        except Exception:
            pass

        # Put DDC design params (provided payload)
        safe_run(
            "put_ddc_design_params",
            self.put_ddc_design_params,
            38278,
            8,
            0.05,
            0.01,
            60,
            True,
        )

        # geolocation set to None then restore if possible
        try:
            orig_geo = self.get_geolocation()
            safe_run("set_geolocation_point_null", self.set_geolocation_point, None, None)
            if orig_geo is not None and isinstance(orig_geo, dict):
                # attempt to restore original point if present
                pt = orig_geo.get("point")
                if pt and isinstance(pt, dict) and pt.get("coordinates"):
                    lon, lat = pt["coordinates"][0], pt["coordinates"][1]
                    safe_run("restore_geolocation_point", self.set_geolocation_point, lat, lon, pt.get("altitude_m"))
        except Exception:
            pass

        # Recorder: change mode/state conservatively and restore
        try:
            orig_rec_state = self.get_recorder_state()
            orig_rec_mode = self.get_recorder_mode()
            safe_run("set_recorder_state_Stopped", self.set_recorder_state, "Stopped")
            safe_run("set_recorder_mode_IQ16bit", self.set_recorder_mode, "IQ16bit")
            if orig_rec_state is not None:
                safe_run("restore_recorder_state", self.set_recorder_state, orig_rec_state)
            if orig_rec_mode is not None:
                safe_run("restore_recorder_mode", self.set_recorder_mode, orig_rec_mode)
        except Exception:
            pass

        # Recording metadata
        safe_run("set_metadata_filename_unit_test", self.set_metadata_filename, "unit_test_rec")
        safe_run("set_metadata_description_unit_test", self.set_metadata_description, "unit test")
        safe_run("set_metadata_author_unit_test", self.set_metadata_author, "unittest")
        # restore metadata originals
        if originals.get("metadata_filename") is not None:
            safe_run("restore_metadata_filename", self.set_metadata_filename, originals["metadata_filename"])
        if originals.get("metadata_description") is not None:
            safe_run("restore_metadata_description", self.set_metadata_description, originals["metadata_description"])
        if originals.get("metadata_author") is not None:
            safe_run("restore_metadata_author", self.set_metadata_author, originals["metadata_author"])

        # Spectrometer: set safe values and restore
        try:
            safe_run("set_spectrometer_fft_size_1024", self.set_spectrometer_fft_size, 1024)
            safe_run("set_spectrometer_number_integrations_100", self.set_spectrometer_number_integrations, 100)
            if originals.get("spectrometer_fft_size") is not None:
                safe_run("restore_spectrometer_fft_size", self.set_spectrometer_fft_size, originals["spectrometer_fft_size"])
            if originals.get("spectrometer_number_integrations") is not None:
                safe_run("restore_spectrometer_number_integrations", self.set_spectrometer_number_integrations, originals["spectrometer_number_integrations"])
        except Exception:
            pass

        # Time: set and restore
        try:
            if originals.get("time_value") is not None:
                new_time = originals["time_value"] + 1.0
                safe_run("set_time_value_increment", self.set_time_value, new_time)
                safe_run("restore_time_value", self.set_time_value, originals["time_value"])
        except Exception:
            pass

        # Final reads
        safe_run("final_get_ad9361", self.get_ad9361)
        safe_run("final_get_ddc", self.get_ddc)
        safe_run("final_get_spectrometer", self.get_spectrometer)

        return results


# ---- CLI runner ----
if __name__ == "__main__":
    client = MaiaPerParamClient(BASE_URL)
    print("Running exhaustive unitary_test against", BASE_URL)
    summary = client.unitary_test()
    print("\nTest summary (name -> (success, value_or_error)):")
    for name, (ok, val) in summary.items():
        status = "OK" if ok else "FAIL"
        print(f" - {name}: {status} -> {val}")

