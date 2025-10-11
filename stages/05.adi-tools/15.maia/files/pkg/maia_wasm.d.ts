/* tslint:disable */
/* eslint-disable */
/**
 * Gives the maia-wasm version as a `String`.
 */
export function maia_wasm_version(): string;
/**
 * Gives the version of the git repository as a `String`.
 */
export function maia_wasm_git_version(): string;
/**
 * Initialize the wasm module.
 *
 * This function is set to run as soon as the wasm module is instantiated. It
 * applies some settings that are needed for all kinds of usage of
 * `maia-wasm`. For instance, it sets a panic hook using the
 * [`console_error_panic_hook`] crate.
 */
export function start(): void;
/**
 * Starts the maia-wasm web application.
 *
 * This function starts the maia-wasm application. It should be called from
 * JavaScript when the web page is loaded. It sets up all the objects and
 * callbacks that keep the application running.
 */
export function maia_wasm_start(): void;

export type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;

export interface InitOutput {
  readonly memory: WebAssembly.Memory;
  readonly maia_wasm_version: () => [number, number];
  readonly maia_wasm_git_version: () => [number, number];
  readonly start: () => void;
  readonly maia_wasm_start: () => [number, number];
  readonly __externref_table_alloc: () => number;
  readonly __wbindgen_export_1: WebAssembly.Table;
  readonly __wbindgen_exn_store: (a: number) => void;
  readonly __wbindgen_free: (a: number, b: number, c: number) => void;
  readonly __wbindgen_malloc: (a: number, b: number) => number;
  readonly __wbindgen_realloc: (a: number, b: number, c: number, d: number) => number;
  readonly __wbindgen_export_6: WebAssembly.Table;
  readonly __externref_table_dealloc: (a: number) => void;
  readonly closure2_externref_shim: (a: number, b: number, c: any) => void;
  readonly closure6_externref_shim: (a: number, b: number) => any;
  readonly _dyn_core__ops__function__Fn_____Output___R_as_wasm_bindgen__closure__WasmClosure___describe__invoke__h399b42d5089cb7e1: (a: number, b: number) => void;
  readonly _dyn_core__ops__function__FnMut__A____Output___R_as_wasm_bindgen__closure__WasmClosure___describe__invoke__h2774b7d896c85539: (a: number, b: number, c: number) => void;
  readonly closure19_externref_shim: (a: number, b: number, c: any) => any;
  readonly closure272_externref_shim: (a: number, b: number, c: any) => void;
  readonly closure305_externref_shim: (a: number, b: number, c: any, d: any) => void;
  readonly __wbindgen_start: () => void;
}

export type SyncInitInput = BufferSource | WebAssembly.Module;
/**
* Instantiates the given `module`, which can either be bytes or
* a precompiled `WebAssembly.Module`.
*
* @param {{ module: SyncInitInput }} module - Passing `SyncInitInput` directly is deprecated.
*
* @returns {InitOutput}
*/
export function initSync(module: { module: SyncInitInput } | SyncInitInput): InitOutput;

/**
* If `module_or_path` is {RequestInfo} or {URL}, makes a request and
* for everything else, calls `WebAssembly.instantiate` directly.
*
* @param {{ module_or_path: InitInput | Promise<InitInput> }} module_or_path - Passing `InitInput` directly is deprecated.
*
* @returns {Promise<InitOutput>}
*/
export default function __wbg_init (module_or_path?: { module_or_path: InitInput | Promise<InitInput> } | InitInput | Promise<InitInput>): Promise<InitOutput>;
