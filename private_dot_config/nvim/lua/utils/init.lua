local M = {}

local function full_document_range(bufnr)
  local last_line = vim.api.nvim_buf_line_count(bufnr) - 1
  local last_text = (vim.api.nvim_buf_get_lines(bufnr, last_line, last_line + 1, true)[1] or "")
  return {
    start = { line = 0, character = 0 },
    ["end"] = { line = last_line, character = #last_text },
  }
end

M.call_format_synchronously = function(lsp_name)
  vim.lsp.buf.format({
    async = false,
    filter = function(client)
      return client.name == lsp_name
    end,
  })
end

M.call_code_action_synchronously = function(lsp_name, code_action)
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = lsp_name })
  if #clients == 0 then
    return
  end
  local params = vim.lsp.util.make_range_params(0, clients[1].offset_encoding)
  params.context = {
    only = { code_action },
    diagnostics = {},
  }
  params.range = full_document_range(bufnr)
  local timeout_ms = 3000
  local response = clients[1]:request_sync("textDocument/codeAction", params, timeout_ms, bufnr)

  if not response or not response.result then
    vim.notify("No response from " .. lsp_name .. " for organizing imports", vim.log.levels.WARN)
    return
  end

  local action = nil
  for _, res in ipairs(response.result or {}) do
    if res.isPreferred then
      action = res
      break
    end
  end
  if not action then
    return
  end
  local resolved = clients[1]:request_sync("codeAction/resolve", action, timeout_ms, bufnr)

  if resolved and resolved.result then
    action = resolved.result
  end
  if action.edit then
    vim.lsp.util.apply_workspace_edit(action.edit, clients[1].offset_encoding)
  elseif action.command then
    clients[1]:execute_command(action.command)
  end
end

M.get_os_name = function()
  if vim.fn.has("mac") == 1 then
    return "mac"
  elseif vim.fn.has("linux") == 1 then
    return "linux"
  elseif vim.fn.has("unix") == 1 then
    return "unix"
  elseif vim.fn.has("sun") == 1 then
    return "sun"
  elseif vim.fn.has("bsd") == 1 then
    return "bsd"
  elseif vim.fn.has("win32") == 1 then
    return "win32"
  elseif vim.fn.has("win64") == 1 then
    return "win64"
  elseif vim.fn.has("wsl") == 1 then
    return "wsl"
  end
end

M.get_nvim_agent = function()
  local agent = os.getenv("NVIM_AGENT")
  if not agent or agent == "" then
    return "gemini"
  end
  return agent
end

return M
