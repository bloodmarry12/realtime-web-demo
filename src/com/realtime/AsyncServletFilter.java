package com.realtime;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author nieyong
 * @time 2012-8-17
 * @version 1.0
 */
/**
 * 异步拦截器
 * 
 * @author yongboy
 * @date 2011-1-14
 * @version 1.0
 */
@WebFilter(dispatcherTypes = { DispatcherType.REQUEST, DispatcherType.FORWARD,
		DispatcherType.INCLUDE }, urlPatterns = { "/demoAsyncLink" }, asyncSupported = true // 支持异步Servlet
)
public class AsyncServletFilter implements Filter {
	private Log log = LogFactory.getLog(AsyncServletFilter.class);

	public AsyncServletFilter() {
	}

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		log.info("it was filted now");

		MarkWapperedResponse wapper = new MarkWapperedResponse(
				(HttpServletResponse) response);

		chain.doFilter(request, wapper);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}
}