local M = {}
 function M.progress_report(_, result, ctx)
   local lsp = vim.lsp
   local info = {
      client_id = ctx.client_id,
   }

   local kind = "report"
   if result.complete then
      kind = "end"
   elseif result.workDone == 0 then
      kind = "begin"
   elseif result.workDone > 0 and result.workDone < result.totalWork then
      kind = "report"
   else
      kind = "end"
   end

   local percentage = 0
   if result.totalWork > 0 and result.workDone >= 0 then
      percentage = result.workDone / result.totalWork * 100
   end

   local msg = {
      token = result.id,
      value = {
         kind = kind,
         percentage = percentage,
         title = result.subTask,
         message = result.subTask,
      },
   }
   -- print(vim.inspect(result))

   lsp.handlers["$/progress"](nil, msg, info)
end
return M
