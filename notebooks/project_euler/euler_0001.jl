### A Pluto.jl notebook ###
# v0.19.38

using Markdown
using InteractiveUtils

# ╔═╡ 3d398400-ca09-11ee-004c-033560a0b368
using DrWatson

# ╔═╡ 6b2aa7d9-e746-4ae1-8a61-484e8d681e5f
function activate_proj(
	env_name = "NailSTack",
	env_path = DrWatson.findproject())

	# Is it a valid path
	ispath(env_path) ? true : error("require valid path")

	# Get Paths
	current_path = pwd()
	env_path = ispath(env_path) ? normpath(env_path) : abspath(env_path)

	split_current = splitpath(current_path)
	split_env = splitpath(env_path)

	# Confirm Path is different from current location // Janky
	if issubset(split_env, split_current)
		quickactivate(@__DIR__, env_name);
	else
		# cd(env_path)
		quickactivate(env_path, env_name);
	end

end;

# ╔═╡ 0b59f730-04ca-4b37-8b33-f74cb1e7231a
begin
	# Load Pluto from Julia envionment already in folder
	oldstd = stdout
	redirect_stdout(devnull)
		activate_proj();
	redirect_stdout(oldstd)
	
	using Turing 
	using StatsKit
	using ShortCodes
	using PlutoUI

	using RCall
	using PyCall
end

# ╔═╡ 20ab4ad3-5542-4827-97e3-54815ad9c80c
md"""
# Load Packages
"""

# ╔═╡ 3d53de88-4896-4ae8-9f8e-1d3053258e69
TableOfContents(
	title = "📚 Table of Contents",
	indent = true,
	depth = 5,
	aside = true)

# ╔═╡ afdd4c9f-cfc3-442f-a59d-b08a5b61ee66
md"---"

# ╔═╡ 96548e45-9e00-4b2a-b79b-9ac9ff40dbd8
md"# Activity"

# ╔═╡ 0b57443e-4dfa-474f-a02f-b453657af43c
md"""
## Multiples of 3 or 5

**Problem**: **1**
"""

# ╔═╡ 5ea24a9c-32bc-461d-9aa5-819832bd88f8
md"""
If we list all the natural numbers below 10 that are multiples of 3 or 5 we get 3, 5, 6, and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1,000.
"""

# ╔═╡ d7071750-dd08-4cce-977c-8cf44044b413
md"## Solution"

# ╔═╡ a3b9db92-bb62-4a2f-9667-4d57e8d24bf0
md"### Julia"

# ╔═╡ f763d099-4e95-4c9f-aa6f-b63e4453ce3a
function sum_of_mult(val::Int)
	n = 0
	for i in 1:1:Int64(val - 1)
		isequal(rem(i, 3), 0) || isequal(rem(i, 5), 0) ? n += i : continue
	end
	return n
end

# ╔═╡ 43f5d191-a066-456d-9ca3-6b7f7cad746b
sum_of_mult(1000)

# ╔═╡ ec5512b5-78e0-409e-afa3-2b6760857f17
md"""
##### Note:

Nothing to note.
"""

# ╔═╡ 8288808f-95da-41be-9377-7d3b79c6b6e5
md"---"

# ╔═╡ 72713e68-ba89-4f90-8449-d2ab22aed822
md"### R"

# ╔═╡ 8d04e034-23f7-4a3b-bb44-20d70f0ff617
R"""
sum_of_mult <- function(val){
	x <- 1:(val-1)
	y <- ((x %% 3) == 0) | ((x %% 5) == 0)
	z <- x * y
	sum(z)
}

sum_of_mult(1000)
"""

# ╔═╡ ba150da5-0a27-4de6-8b00-4091e264571b
md"""
##### Note:

Avoided using a for loop and took advantage of R's vectorisation and that Bools are treated as 1's (True) & 0's (False).
"""

# ╔═╡ 7e2ea8f8-4421-497c-af10-ed64bfd0bd03
md"---"

# ╔═╡ 2a6f66ef-39f9-4902-9bc5-c3ea7ee6c98f
md"### Python"

# ╔═╡ 2ecdda92-0e14-478a-8d39-20561f66c95c
begin
	py"""
def sum_of_mult(val):
	n = 0
	for i in range(val):
		if (i % 3 == 0) or (i % 5 == 0):
			n += i
	return n
"""
	sum_of_mult_py = py"sum_of_mult"
end

# ╔═╡ 175608fa-dd16-4257-907b-63a7b40811f8
sum_of_mult_py(1000)

# ╔═╡ d879014e-265d-441b-a25f-c4c8ec2cd2d9
md"""
##### Note:

As it's 0 index, there's no need to adjust the iterator, and we can just use range. It starts from zero, which we can ignore in this problem.

Also PyCall seems to have a different style than RCall. It seems I have to bind the python object and then call it rather than in R where it'll just give me the result.
"""

# ╔═╡ Cell order:
# ╟─20ab4ad3-5542-4827-97e3-54815ad9c80c
# ╟─3d398400-ca09-11ee-004c-033560a0b368
# ╟─6b2aa7d9-e746-4ae1-8a61-484e8d681e5f
# ╟─0b59f730-04ca-4b37-8b33-f74cb1e7231a
# ╟─3d53de88-4896-4ae8-9f8e-1d3053258e69
# ╟─afdd4c9f-cfc3-442f-a59d-b08a5b61ee66
# ╟─96548e45-9e00-4b2a-b79b-9ac9ff40dbd8
# ╟─0b57443e-4dfa-474f-a02f-b453657af43c
# ╟─5ea24a9c-32bc-461d-9aa5-819832bd88f8
# ╟─d7071750-dd08-4cce-977c-8cf44044b413
# ╟─a3b9db92-bb62-4a2f-9667-4d57e8d24bf0
# ╠═f763d099-4e95-4c9f-aa6f-b63e4453ce3a
# ╠═43f5d191-a066-456d-9ca3-6b7f7cad746b
# ╟─ec5512b5-78e0-409e-afa3-2b6760857f17
# ╟─8288808f-95da-41be-9377-7d3b79c6b6e5
# ╟─72713e68-ba89-4f90-8449-d2ab22aed822
# ╠═8d04e034-23f7-4a3b-bb44-20d70f0ff617
# ╟─ba150da5-0a27-4de6-8b00-4091e264571b
# ╟─7e2ea8f8-4421-497c-af10-ed64bfd0bd03
# ╠═2a6f66ef-39f9-4902-9bc5-c3ea7ee6c98f
# ╠═2ecdda92-0e14-478a-8d39-20561f66c95c
# ╠═175608fa-dd16-4257-907b-63a7b40811f8
# ╟─d879014e-265d-441b-a25f-c4c8ec2cd2d9
