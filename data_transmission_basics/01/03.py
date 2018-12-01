
# coding: utf-8

# In[1]:


import math
import matplotlib.pyplot as plt


# In[2]:


fs = 2300  # hz
T = 1.8  # s


# In[3]:


size = int(T * fs)


# In[4]:


def x(n):
    t = n / fs
    if t >= 0.7:
        return 0.2 * math.sin(40 * math.pi * t) * math.sin(20 * math.pi * t)
    elif t >= 0.2:
        return (1/t) * 0.8 * math.sin(34 * math.pi * t)
    else:
        return (t + 0.5) * math.sin(50 * math.pi * t)


# In[5]:


result = [x(i) for i in range(size)]
result


# In[6]:


plt.scatter(list(range(size)), result)

