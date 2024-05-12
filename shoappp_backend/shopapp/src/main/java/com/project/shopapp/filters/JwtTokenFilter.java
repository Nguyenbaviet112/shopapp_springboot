package com.project.shopapp.filters;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Component
public class JwtTokenFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(@NonNull HttpServletRequest request,
                                    @NonNull HttpServletResponse response,
                                    @NonNull FilterChain filterChain)
            throws ServletException, IOException
    {
        final List<Pair<String, String>> bypassTokens = Arrays.asList(
                Pair.of("${api.prefix}/products", "GET"),
                Pair.of("${api.prefix}/categories", "GET"),
                Pair.of("${api.prefix}/users/register", "POST"),
                Pair.of("${api.prefix}/users/login", "POST")

        );

        for (Pair<String, String> bypassToken : bypassTokens)
        {
            if (request.getServletPath().contains(bypassToken.getFirst()) &&
            request.getMethod().equals(bypassToken.getSecond())
            {
                filterChain.doFilter(request, response);  // enable bypass
            }
        }


    }

    private boolean isBypassToken(@NonNull HttpServletRequest request)
    {
        final List<Pair<String, String>> bypassTokens = Arrays.asList(
                Pair.of("${api.prefix}/products", "GET"),
                Pair.of("${api.prefix}/categories", "GET"),
                Pair.of("${api.prefix}/users/register", "POST"),
                Pair.of("${api.prefix}/users/login", "POST")

        );

        for (Pair<String, String> bypassToken : bypassTokens)
        {
            if (request.getServletPath().contains(bypassToken.getFirst()) &&
                    request.getMethod().equals(bypassToken.getSecond())
            {
                return true;
            }
        }

        return false;

    }

}
