### Pre-process: .fpp -> .f90 via Fypp

# Create a list of the files to be preprocessed
set(fppFiles
    test_mean.fypp
    test_mean_f03.fypp
    test_median.fypp
    test_distribution_uniform.fypp
)

# Custom preprocessor flags
if(DEFINED CMAKE_MAXIMUM_RANK)
  set(fyppFlags "-DMAXRANK=${CMAKE_MAXIMUM_RANK}")
elseif(f03rank)
  set(fyppFlags)
else()
  set(fyppFlags "-DVERSION90")
endif()

fypp_f90("${fyppFlags}" "${fppFiles}" outFiles)

ADDTEST(corr)
ADDTEST(cov)
ADDTEST(mean)
ADDTEST(median)
ADDTEST(moment)
ADDTEST(rawmoment)
ADDTEST(var)
ADDTEST(varn)
ADDTEST(random)
ADDTEST(distribution_uniform)

if(DEFINED CMAKE_MAXIMUM_RANK)
    if(${CMAKE_MAXIMUM_RANK} GREATER 7)
        ADDTEST(mean_f03)
    endif()
elseif(f03rank)
    ADDTEST(mean_f03)
endif()
